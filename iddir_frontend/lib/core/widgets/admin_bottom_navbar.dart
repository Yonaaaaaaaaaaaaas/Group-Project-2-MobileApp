import 'dart:ui';
import 'package:flutter/material.dart';

class AdminBottomNavBar extends StatelessWidget {
  const AdminBottomNavBar({super.key});

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
          AdminNavItem(
            icon: Icons.group_outlined,
            label: 'Members',
            routeName: '/member-management',
            isActive: currentRoute == '/member-management',
          ),
          AdminNavItem(
            icon: Icons.check_circle_outline,
            label: 'Approvals',
            routeName: '/event-approval',
            isActive: currentRoute == '/event-approval',
          ),
          AdminNavItem(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Finance',
            routeName: '/financial-management',
            isActive: currentRoute == '/financial-management',
          ),
          AdminNavItem(
            icon: Icons.announcement_outlined,
            label: 'Announcements',
            routeName: '/admin-announcement',
            isActive: currentRoute == '/admin-announcement',
          ),
        ],
      ),
    );
  }
}

class AdminNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;
  final bool isActive;

  const AdminNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.routeName,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: isActive
              ? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)
              : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
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
