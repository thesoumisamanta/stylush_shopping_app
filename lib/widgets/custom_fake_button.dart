import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class CustomFakeButton extends StatelessWidget {
  final String buttonTitle;
  final double? width;
  final double? height;
  final Color bgColor;
  
  const CustomFakeButton({
    super.key,
    required this.buttonTitle,
    this.width,
    this.height,
    this.bgColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? ResponsiveConstants.screenHeight(context) * 0.045,
      width: width ?? ResponsiveConstants.screenWidth(context) * 0.25,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(4),
        color: bgColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonTitle, 
            style: TextStyle(
              color: AppColors.white,
              fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
            ),
          ),
          SizedBox(width: ResponsiveConstants.screenWidth(context) * 0.02),
          SvgPicture.asset(
            'assets/icons/forward_arrow.svg',
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            height: ResponsiveConstants.screenWidth(context) * 0.035,
            width: ResponsiveConstants.screenWidth(context) * 0.035,
          ),
        ],
      ),
    );
  }
}