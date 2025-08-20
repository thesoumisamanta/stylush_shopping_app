import 'package:flutter/material.dart';

enum ButtonType { elevated, outlined, text }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double? height; 
  final bool expand; 

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.type,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 6,
    this.height,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = SizedBox(
      height: height, 
      child: _buildButton(context),
    );

    if (expand) {
      return Expanded(child: buttonChild); 
    }
    return buttonChild;
  }

  Widget _buildButton(BuildContext context) {
    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Text(label),
        );

      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor,
            side: BorderSide(color: textColor ?? Theme.of(context).primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Text(label),
        );

      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Text(label),
        );
    }
  }
}
