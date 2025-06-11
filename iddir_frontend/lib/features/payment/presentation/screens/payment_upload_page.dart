import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart'; // Import for Uint8List
import '../providers/payment_provider.dart';

class PaymentUploadPage extends ConsumerStatefulWidget {
  const PaymentUploadPage({super.key});

  @override
  ConsumerState<PaymentUploadPage> createState() => _PaymentUploadPageState();
}

class _PaymentUploadPageState extends ConsumerState<PaymentUploadPage> {
  File? _selectedImage;
  Uint8List? _selectedImageBytes; // To store image bytes for web
  String? _selectedImageFileName; // To store filename for web
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize payment details
    Future.microtask(() {
      ref.read(userPaymentProvider.notifier).getPaymentDetails();
    });
  }

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
          withData: true,
        );
        if (result != null && result.files.single.bytes != null) {
          setState(() {
            _selectedImage = null; // Clear file path for web
            _selectedImageBytes = result.files.single.bytes;
            _selectedImageFileName = result.files.single.name;
          });
        }
      } else {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _selectedImage = File(pickedFile.path);
            _selectedImageBytes = null; // Clear bytes for non-web
            _selectedImageFileName = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _uploadReceipt() async {
    if (!kIsWeb && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a receipt image first')),
      );
      return;
    } else if (kIsWeb && _selectedImageBytes == null) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a receipt image first')),
      );
      return;
    }

    final success = await ref.read(userPaymentProvider.notifier).uploadReceipt(
      filePath: !kIsWeb ? _selectedImage!.path : null, // Pass filePath for non-web
      imageBytes: kIsWeb ? _selectedImageBytes : null, // Pass bytes for web
      fileName: kIsWeb ? _selectedImageFileName : null, // Pass filename for web
    );
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt uploaded successfully')),
      );
      setState(() {
        _selectedImage = null;
        _selectedImageBytes = null;
        _selectedImageFileName = null;
      });
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload receipt')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentDetails = ref.watch(userPaymentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Upload',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(userPaymentProvider.notifier).getPaymentDetails(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Payment Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Status',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      paymentDetails.when(
                        data: (details) {
                          if (details == null) {
                            return const Text('No payment information available');
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status: ${details.paymentStatus?.toUpperCase() ?? 'UNKNOWN'}',
                                style: TextStyle(
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 18,
                                  color: details.paymentStatus == 'paid'
                                      ? Colors.green
                                      : details.paymentStatus == 'pending'
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                              ),
                              if (details.paymentApprovedAt != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Approved on: ${details.paymentApprovedAt!.toLocal().toString().split('.')[0]}',
                                  style: const TextStyle(
                                    fontFamily: 'Instrument Sans',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                              if (details.receiptUrl != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Receipt: ${details.receiptUrl ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Instrument Sans',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Upload Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upload Payment Receipt',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_selectedImage != null || _selectedImageBytes != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: kIsWeb
                            ? Image.memory(
                                _selectedImageBytes!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _selectedImage!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Select Receipt Image'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF08B9AF),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _uploadReceipt,
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('Upload Receipt'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 