import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<Widget> items;
  final double? height;
  final Color backgroundColor;
  final double? spacing;
  final double? padding;

  const CustomBottomNavBar({
    super.key,
    required this.items,
    this.height,
    this.backgroundColor = AppColors.white,
    this.spacing,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight =
        height ?? ResponsiveConstants.screenHeight(context) * 0.11;
    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              Expanded(child: items[i]),
              if (i != items.length - 1) SizedBox(width: spacing),
            ],
          ],
        ),
      ),
    );
  }
}
