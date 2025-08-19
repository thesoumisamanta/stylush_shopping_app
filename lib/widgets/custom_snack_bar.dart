import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double height = 60,
    double borderRadius = 12,
    EdgeInsets margin = const EdgeInsets.all(12),
    Duration duration = const Duration(seconds: 3),
    double? fontSize,
    IconData? icon,
  }) {
    final double resolvedFontSize =
        fontSize ?? ResponsiveConstants.screenWidth(context) * 0.04;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: margin,
        duration: duration,
        content: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: textColor, size: ResponsiveConstants.screenHeight(context) * 0.03),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor,
                    fontSize: resolvedFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
