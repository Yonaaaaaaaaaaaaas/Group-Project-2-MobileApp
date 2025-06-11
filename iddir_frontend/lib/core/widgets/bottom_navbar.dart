import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 9),
      color: const Color(0xFF08B9AF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavItem(
            icon: Icons.announcement_outlined,
            label: 'Announcements',
            isActive: currentRoute == '/announcement',
            onTap: () {
              if (currentRoute != '/announcement') {
                Navigator.pushReplacementNamed(context, '/announcement');
              }
            },
          ),
          NavItem(
            icon: Icons.send_outlined,
            label: 'Request',
            isActive: currentRoute == '/service-request',
            onTap: () {
              if (currentRoute != '/service-request') {
                Navigator.pushReplacementNamed(context, '/service-request');
              }
            },
          ),
          NavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: currentRoute == '/profile',
            onTap: () {
              if (currentRoute != '/profile') {
                Navigator.pushReplacementNamed(context, '/profile');
              }
            },
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter:
              isActive
                  ? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)
                  : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: isActive ? Colors.white : Colors.black),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
