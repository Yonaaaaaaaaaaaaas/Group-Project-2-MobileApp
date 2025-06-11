import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iddir_app/core/widgets/bottom_navbar.dart';
import 'package:iddir_app/features/profile/data/models/profile_model.dart';
import 'package:iddir_app/features/profile/presentation/providers/profile_provider.dart';
import 'package:iddir_app/features/profile/presentation/screens/profile_form_page.dart';
import 'package:iddir_app/features/payment/presentation/screens/payment_upload_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      body: Column(
        children: [
          const CurvedHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60), // Space for profile image positioning
                  // Profile Image with Edit Icon
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: profileState.when(
                          data: (profile) {
                            if (profile != null && profile.fullProfilePictureUrl != null) {
                              return NetworkImage(profile.fullProfilePictureUrl!) as ImageProvider;
                            } else {
                              return const AssetImage('assets/images/profile.png');
                            }
                          },
                          loading: () => const AssetImage('assets/images/profile.png'),
                          error: (_, __) => const AssetImage('assets/images/profile.png'),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              if (kIsWeb) {
                                final result = await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                  allowMultiple: false,
                                  withData: true,
                                );
                                if (result != null && result.files.single.bytes != null) {
                                  final file = result.files.single;
                                  final bytes = file.bytes!;
                                  final extension = file.extension?.toLowerCase() ?? 'jpg';
                                  
                                  // Create a proper filename with extension
                                  final filename = 'profile_picture.$extension';
                                  
                                  try {
                                    // Create FormData with proper file type
                                    final formData = FormData.fromMap({
                                      'profilePicture': MultipartFile.fromBytes(
                                        bytes,
                                        filename: filename,
                                        contentType: MediaType('image', extension),
                                      ),
                                    });

                                    await ref.read(profileProvider.notifier).updateProfilePicture(formData);
                                    // Refresh profile data after successful upload
                                    await ref.read(profileProvider.notifier).getProfile();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Profile picture updated!')),
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Failed to update profile picture: $e')),
                                      );
                                    }
                                  }
                                }
                              } else {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 80,
                                );
                                if (pickedFile != null) {
                                  try {
                                    await ref.read(profileProvider.notifier).updateProfilePicture(pickedFile.path);
                                    // Refresh profile data after successful upload
                                    await ref.read(profileProvider.notifier).getProfile();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Profile picture updated!')),
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Failed to update profile picture: $e')),
                                      );
                                    }
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Name and email
                  profileState.when(
                    data: (profile) => Column(
                      children: [
                        Text(
                          profile?.name ?? 'Not logged in',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            height: 28 / 22,
                            letterSpacing: 0,
                            color: Colors.black,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile?.email ?? '',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 20 / 14,
                            letterSpacing: 0.25,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Error loading profile',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SettingsContainer(),
                  const SizedBox(height: 40), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
              ),
              const SizedBox(width: 12),
              const Text(
                'Profile',
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
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DebugGestureDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  
  const DebugGestureDetector({
    super.key,
    required this.child,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        debugPrint('GestureDetector tapped!');
        onTap();
      },
      child: child,
    );
  }
}

class SettingsContainer extends ConsumerWidget {
  const SettingsContainer({super.key});

  Future<void> _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        // Attempt to delete account
        final success = await ref.read(profileProvider.notifier).deleteAccount();

        // Close loading indicator
        if (context.mounted) {
          Navigator.pop(context); // Close loading dialog
        }

        if (success) {
          // Show success message and navigate to login
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate to login page and clear navigation stack
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/onboarding',  
              (route) => false,
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to delete account. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        // Close loading indicator if it's still showing
        if (context.mounted) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Payment Row (Add this new section)
          DebugGestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentUploadPage()),
              );
            },
            child: const SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.payment_outlined, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Payment & Receipts',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: 0.25,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Edit Profile Row
          DebugGestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile-form');
            },
            child: const SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Edit profile information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: 0.25,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Notification Row
          DebugGestureDetector(
            onTap: () => print('Notifications tapped'),
            child: const SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.notifications_none, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Response from admin',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: 0.25,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Delete Account Row
          DebugGestureDetector(
            onTap: () => _handleDeleteAccount(context, ref),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.red.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 12),
                  Text(
                    'Delete account',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: 0.25,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Events Row
          DebugGestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/events');
            },
            child: const SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.event_note_outlined, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    'Events',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: 0.25,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          
        ],
      ),
    );
  }
}