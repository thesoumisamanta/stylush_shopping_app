import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final double? height;
  final TextEditingController? searchController;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool enabled;
  const CustomSearchBar({
    super.key,
    this.height,
    this.searchController,
    this.onChanged,
    this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText,
      controller: searchController,
      onChanged: onChanged,
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: AppColors.grey2,
          fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
        ),
      ),
      leading: SvgPicture.asset(
        'assets/icons/search.svg',
        colorFilter: ColorFilter.mode(AppColors.grey2, BlendMode.srcIn),
        height: ResponsiveConstants.screenHeight(context) * 0.025,
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
        minHeight: height ?? ResponsiveConstants.screenHeight(context) * 0.05,
      ),
    );
  }
}
