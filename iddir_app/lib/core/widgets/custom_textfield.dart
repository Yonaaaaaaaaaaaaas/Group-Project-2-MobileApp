import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String placeholder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int maxLines;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.placeholder,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
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
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: placeholder,
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
    );
  }
}