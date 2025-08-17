import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final double? height;
  const CustomSearchBar({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search any product',
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: AppColors.grey2,
          fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
        ),
      ),
      leading: SvgPicture.asset(
        'assets/icons/search.svg',
        colorFilter: ColorFilter.mode(AppColors.grey2, BlendMode.srcIn),
        height: ResponsiveConstants.screenWidth(context) * 0.04,
      ),
      trailing: [
        SvgPicture.asset(
          'assets/icons/mic.svg',
          colorFilter: ColorFilter.mode(AppColors.grey2, BlendMode.srcIn),
          height: ResponsiveConstants.screenHeight(context) * 0.03,
        ),
      ],
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.white),
      elevation: WidgetStatePropertyAll(2),
      constraints: BoxConstraints(
        minHeight: ResponsiveConstants.screenHeight(context) * 0.05,
      ),
    );
  }
}
