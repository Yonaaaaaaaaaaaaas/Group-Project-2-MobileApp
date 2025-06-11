import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/button.dart';
import 'package:iddir_app/features/auth/presentation/providers/auth_provider.dart';
import '../../data/models/user_model.dart';

class SignUpPage extends ConsumerStatefulWidget {
  SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  void _handleNavigation(UserModel user) {
    // Clear form
    _nameController.clear();
    _emailController.clear();
    _addressController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: 'Full Name',
                    placeholder: 'Full name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Email',
                    placeholder: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Address',
                    placeholder: 'Address',
                    controller: _addressController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Phone Number',
                    placeholder: 'Phone number',
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Password',
                    placeholder: '*********',
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Confirm Password',
                    placeholder: '*********',
                    controller: _confirmPasswordController,
                    obscureText: !_confirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (authState.isLoading) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else ...[
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF08B9AF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () async {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match'),
                                ),
                              );
                              return;
                            }
                            await ref.read(authProvider.notifier).register({
                              'name': _nameController.text,
                              'email': _emailController.text,
                              'address': _addressController.text,
                              'phone': _phoneController.text,
                              'password': _passwordController.text,
                              'confirmPassword':
                                  _confirmPasswordController.text,
                            });
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
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
                onTap: () => {
                  Navigator.pop(context),
                },
              ),
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

class AddFileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddFileButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application File',
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFF011815), // #011815
              height: 1.0,
              letterSpacing: 0.0,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 143,
            height: 52,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black.withOpacity(0.4), // Optional border color
                width: 1,
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.upload_file, size: 24, color: Colors.black),
                const SizedBox(width: 6),
                const Text(
                  'Add File',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
