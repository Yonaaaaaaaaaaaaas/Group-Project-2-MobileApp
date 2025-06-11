import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/button.dart';
import 'package:iddir_app/features/announcement/presentation/providers/announcement_provider.dart';
import 'package:iddir_app/features/auth/presentation/screens/signin_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import '../../data/models/announcement_model.dart';

class AddAnnouncementPage extends ConsumerStatefulWidget {
  const AddAnnouncementPage({super.key});

  @override
  ConsumerState<AddAnnouncementPage> createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends ConsumerState<AddAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  Uint8List? _webImageBytes;
  bool _isLoading = false;
  String? _error;
  AnnouncementModel? _editingAnnouncement;
  static const int maxImageSizeBytes = 2 * 1024 * 1024; // 2MB

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is AnnouncementModel && _editingAnnouncement == null) {
      _editingAnnouncement = args;
      _titleController.text = args.title;
      _dateController.text = args.date.toIso8601String().split('T').first;
      _addressController.text = '';
      _locationController.text = args.location;
      _descriptionController.text = args.description;
      // Note: image is not preloaded for editing
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        if (bytes.length > maxImageSizeBytes) {
          setState(() {
            _error = 'Image is too large. Please select an image smaller than 2MB.';
          });
          return;
        }
        setState(() {
          _webImageBytes = bytes;
          _imageFile = null;
          _error = null;
        });
      } else {
        final file = File(pickedFile.path);
        final fileSize = await file.length();
        if (fileSize > maxImageSizeBytes) {
          setState(() {
            _error = 'Image is too large. Please select an image smaller than 2MB.';
          });
          return;
        }
        setState(() {
          _imageFile = file;
          _webImageBytes = null;
          _error = null;
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final notifier = ref.read(announcementProvider.notifier);
    try {
      final data = {
        'title': _titleController.text.trim(),
        'date': _dateController.text.trim(),
        'address': _addressController.text.trim(),
        'location': _locationController.text.trim(),
        'description': _descriptionController.text.trim(),
      };
      dynamic imageData;
      if (kIsWeb && _webImageBytes != null) {
        imageData = MultipartFile.fromBytes(
          _webImageBytes!,
          filename: 'announcement_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        );
      } else if (_imageFile != null) {
        imageData = await MultipartFile.fromFile(_imageFile!.path);
      }
      bool success = false;
      if (_editingAnnouncement != null) {
        // Edit mode
        success = await notifier.updateAnnouncement(_editingAnnouncement!.id, data, imageData);
      } else {
        // Add mode
        success = await notifier.createAnnouncement(data, imageData);
      }
      if (success) {
        await notifier.getAllAnnouncements();
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        setState(() {
          _error = _editingAnnouncement != null
              ? 'Failed to update announcement.'
              : 'Failed to create announcement.';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editingAnnouncement != null;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CurvedHeader(title: isEdit ? 'Edit Announcement' : 'Add Announcement'),
              const SizedBox(height: 25),
              CustomTextField(
                labelText: 'Title:',
                placeholder: 'Enter the title..',
                controller: _titleController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Date:',
                placeholder: 'Enter the date of the announcement..',
                controller: _dateController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Address:',
                placeholder: 'Enter your address..',
                controller: _addressController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Location:',
                placeholder: 'Enter the location..',
                controller: _locationController,
              ),
              const SizedBox(height: 20),
              // Multiline Description Field
              SizedBox(
                width: 345,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFF011815),
                        height: 1.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Enter description...',
                        hintStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.0,
                          letterSpacing: 0.0,
                          color: Color(0x80000000),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0x6E000000),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFF000000),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Upload Image Section
              SizedBox(
                width: 345,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload Image',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFF011815),
                        height: 1.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: kIsWeb
                            ? (_webImageBytes == null
                                ? (_editingAnnouncement?.image != null && _editingAnnouncement?.fullImageUrl != null
                                    ? Image.network(_editingAnnouncement!.fullImageUrl!, fit: BoxFit.cover)
                                    : const Center(
                                        child: Text(
                                          'Tap to upload image',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ))
                                : Image.memory(_webImageBytes!, fit: BoxFit.cover))
                            : (_imageFile == null
                                ? (_editingAnnouncement?.image != null && _editingAnnouncement?.fullImageUrl != null
                                    ? Image.network(_editingAnnouncement!.fullImageUrl!, fit: BoxFit.cover)
                                    : const Center(
                                        child: Text(
                                          'Tap to upload image',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ))
                                : Image.file(_imageFile!, fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      label: isEdit ? 'Update Announcement' : 'Add Announcement',
                      backgroundColor: const Color(0xFF08B9AF),
                      onPressed: _submit,
                      aspectRatioVal: 4,
                      lablefont: 16,
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedHeader extends StatelessWidget {
  final String title;
  const CurvedHeader({super.key, this.title = 'Announcement details'});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopCurveClipper(),
      child: Container(
        height: 200, // Adjust as needed
        color: const Color(0xFFEBF0F0), // Teal-ish color from image
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: GestureDetector(
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 40); // Start down from top-left

    // Make the curve start lower and rise to the right side
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height + 20, // Control point (swollen left)
      size.width * 0.5,
      size.height - 10, // Mid point (smoother center)
    );

    path.quadraticBezierTo(
      size.width * 0.95,
      size.height - 50, // Control point (gentle right)
      size.width,
      size.height - 20, // End at top-right
    );

    path.lineTo(size.width, 0); // Top-right corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
