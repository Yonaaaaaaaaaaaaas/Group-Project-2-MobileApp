import 'package:flutter/material.dart';
import 'package:iddir_app/core/widgets/button.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurvedHeader(),
            SizedBox(height: 25),
            Positioned(
              top: 317,
              left: 16,
              child: Container(
                width: 390,
                // height: 420,
                padding: const EdgeInsets.fromLTRB(60, 70, 60, 70),
                decoration: BoxDecoration(
                  color: const Color(
                    0xDFF0EDED,
                  ).withOpacity(0.7),// Lighter gray with ~87% opacity
                  borderRadius: BorderRadius.circular(33),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000), // #00000040
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Verification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              height: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Enter the code admin sent you through: +251900000000',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // OTP Fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            return Container(
                              width: 30,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color.fromARGB(239, 255, 255, 255).withOpacity(0.43), // Solid black border
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: const TextStyle(
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 1.0,
                                ),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 25),
                        const Text(
                          'resend the code?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 1.0,
                            color: Color(0xFF9E9E9E), // Light gray
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Submit Button
                    Center(
                      child: CustomButton(
                        label: 'Submit',
                        aspectRatioVal: 4.35,
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        backgroundColor: const Color(0xFF08B9AF),
                      ),
                    ),
                  ],
                ),
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
        height: 200, // Adjust as needed
        color: const Color(0xFF08B9AF), // Teal-ish color from image
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16),
          child: Row(
            children: [
              const Icon(Icons.arrow_back, color: Colors.black, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Create an account',
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
