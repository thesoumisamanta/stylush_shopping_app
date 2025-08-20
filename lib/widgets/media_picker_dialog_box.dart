import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class MediaPickerDialogBox extends StatelessWidget {
  const MediaPickerDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveConstants.screenWidth(context) * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Search with a photo',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
              ),
            ),
            SizedBox(height: ResponsiveConstants.screenHeight(context) * 0.02),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  ResponsiveConstants.screenHeight(context) * 0.06,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppColors.orange,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveConstants.screenWidth(context) * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.photo, color: Colors.white),
                        SizedBox(
                          width:
                              ResponsiveConstants.screenWidth(context) * 0.015,
                        ),
                        Text(
                          "Choose from gallery",
                          style: TextStyle(
                            fontSize:
                                ResponsiveConstants.screenWidth(context) * 0.04,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/right_arrow.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ResponsiveConstants.screenHeight(context) * 0.005),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  ResponsiveConstants.screenHeight(context) * 0.06,
                ),
                foregroundColor: AppColors.orange,
                side: BorderSide(color: AppColors.orange),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveConstants.screenWidth(context) * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/camera.svg',
                          colorFilter: ColorFilter.mode(
                            AppColors.orange,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Click a photo',
                          style: TextStyle(
                            fontSize:
                                ResponsiveConstants.screenWidth(context) * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/right_arrow.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.orange,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
