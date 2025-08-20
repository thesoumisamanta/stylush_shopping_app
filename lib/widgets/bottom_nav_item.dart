import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class BottomNavItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final bool isActive;

  const BottomNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: ResponsiveConstants.screenWidth(context) * 0.03,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? AppColors.orange : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
