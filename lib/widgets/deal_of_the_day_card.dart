import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/custom_fake_button.dart';

class DealOfTheDayCard extends StatelessWidget {
  const DealOfTheDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.blue2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveConstants.screenWidth(context) * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deal of the Day',
                    style: TextStyle(
                      fontSize: ResponsiveConstants.screenWidth(context) * 0.045, 
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: ResponsiveConstants.screenHeight(context) * 0.005),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/clock.svg',
                        colorFilter: ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                        height: ResponsiveConstants.screenWidth(context) * 0.04,
                        width: ResponsiveConstants.screenWidth(context) * 0.04,
                      ),
                      SizedBox(width: ResponsiveConstants.screenWidth(context) * 0.01),
                      Expanded(
                        child: Text(
                          '22h 45mins 50s remaining', 
                          style: TextStyle(
                            color: AppColors.white, 
                            fontSize: ResponsiveConstants.screenWidth(context) * 0.03,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomFakeButton(buttonTitle: 'View All')
          ],
        ),
      ),
    );
  }
}