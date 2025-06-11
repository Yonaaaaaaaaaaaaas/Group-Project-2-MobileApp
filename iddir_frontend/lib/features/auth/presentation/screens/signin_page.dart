import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/button.dart';
import 'package:iddir_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:iddir_app/features/profile/presentation/providers/profile_provider.dart';
import '../../data/models/user_model.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;

  void _handleNavigation(UserModel user) {
    // Initialize profile
    ref.read(profileProvider.notifier).initializeProfile();
    
    // Clear form
    _emailController.clear();
    _passwordController.clear();

    // Navigate based on role
    if (user.role == 'admin') {
      Navigator.pushReplacementNamed(context, '/admin-announcement');
    } else {
      Navigator.pushReplacementNamed(context, '/announcement');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<UserModel?>>(authProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        _handleNavigation(next.value!);
      }
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurvedHeader(),
            const SizedBox(height: 25),
            Builder(
              builder: (context) {
                double screenWidth = MediaQuery.of(context).size.width;
                double containerWidth = screenWidth * 0.85;
                double aspectRatio = 345 / 306;
                double containerHeight = containerWidth / aspectRatio;

                return Container(
                  width: containerWidth,
                  // height: containerHeight,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 15,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        labelText: 'Email',
                        placeholder: 'youremail@gmail.com',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: 'Password',
                        placeholder: '*********',
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                      ),
                      const SizedBox(height: 30),
                      if (authState.isLoading) ...[
                        const Center(child: CircularProgressIndicator()),
                      ] else ...[
                        CustomButton(
                          label: 'Log in',
                          aspectRatioVal: 4.35,
                          backgroundColor: const Color(0xFF08B9AF),
                          onPressed: () async {
                            await ref
                                .read(authProvider.notifier)
                                .login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          },
                        ),
                      ],
                      if (authState.hasError)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            authState.error.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                );
              },
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
              GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 28,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 12),
              const Text(
                'Signin',
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

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String placeholder;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.placeholder,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          labelText,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF011815), // #011815
            height: 1.0,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 8),

        // Text Field
        SizedBox(
          width: 345,
          height: 43,
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              height: 1.0,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color(0x80000000), // #00000080
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
                  color: Color(0x6E000000), // #0000006E
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFF000000), // Focus color (stronger)
                  width: 1,
                ),
              ),
            ),
            obscureText: obscureText,
          ),
        ),
      ],
    );
  }
}
