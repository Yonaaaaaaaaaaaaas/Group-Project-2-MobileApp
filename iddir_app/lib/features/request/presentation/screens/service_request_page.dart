import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/button.dart';
import 'package:iddir_app/core/widgets/custom_textfield.dart';

import '../providers/request_provider.dart';

class ServiceRequestPage extends ConsumerStatefulWidget {
  const ServiceRequestPage({super.key});

  @override
  ConsumerState<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends ConsumerState<ServiceRequestPage> {
  final _nameController = TextEditingController();
  final _eventTypeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _eventTypeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    final data = {
      'name': _nameController.text,
      'eventType': _eventTypeController.text,
      'amount': double.tryParse(_amountController.text) ?? 0,
    };

    final success = await ref.read(requestProvider.notifier).createRequest(data);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request submitted successfully')),
      );
      _nameController.clear();
      _eventTypeController.clear();
      _amountController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit request')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurvedHeader(),
            const SizedBox(height: 25),
            CustomTextField(
              controller: _nameController,
              labelText: 'Name:',
              placeholder: 'Enter name..',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _eventTypeController,
              labelText: 'Type:',
              placeholder: 'Type event..',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _amountController,
              labelText: 'Amount:',
              placeholder: 'Amount requested..',
              // keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    label: 'Back',
                    onPressed: () => Navigator.pushNamed(context, '/announcement'),
                    aspectRatioVal: 2,
                    border: true,
                    lablefont: 16,
                  ),
                  CustomButton(
                    label: 'Submit',
                    onPressed: _submitRequest,
                    aspectRatioVal: 2,
                    backgroundColor: const Color(0xFF08B9AF),
                    lablefont: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedHeader extends StatelessWidget {
  const CurvedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopCurveClipper(),
      child: Container(
        height: 200,
        color: const Color(0xFFEBF0F0),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/announcement'),
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Colors.black, size: 28),
                SizedBox(width: 12),
                Text(
                  'Service Request',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
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
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height + 20,
      size.width * 0.5,
      size.height - 10,
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height - 50,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}