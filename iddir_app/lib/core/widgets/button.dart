import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isEnabled;
  final Color backgroundColor;
  final bool border;
  final double aspectRatioVal;
  final double lablefont; // Default height for the button

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.border = false,
    this.aspectRatioVal = 6.3,
    this.lablefont = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 60;
    double aspectRatio = aspectRatioVal; // 405 / 60
    final double width = height * aspectRatio;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey.shade300,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side:
                border
                    ? BorderSide(color: const Color(0xFF709A95), width: 3)
                    : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style:  TextStyle(
            fontFamily: 'Instrument Sans', // Add font in pubspec.yaml
            fontWeight: FontWeight.w600, // Semi-bold
            fontSize: lablefont, // 24
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
