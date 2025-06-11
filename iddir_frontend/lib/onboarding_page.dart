import 'package:flutter/material.dart';
import 'package:iddir_app/core/widgets/button.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 237, height: 274),
            SizedBox(height: 100),
            CustomButton(
              label: 'Create an account',
              backgroundColor: Color(0xFF08B9AF),
              onPressed: () => {
                Navigator.pushNamed(context, '/register'),
              },
            ),

            SizedBox(height: 20),
            CustomButton(label: 'Sign in', border: true, onPressed: () => {
              Navigator.pushNamed(context, '/signin'),
            }),
          ],
        ),
      ),
    );
  }
}
