import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/custom_fake_button.dart';

class TrendingProductsCard extends StatelessWidget {
  const TrendingProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: AppColors.orange5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending Products',
                  style: TextStyle(
                    fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calender.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                      height: ResponsiveConstants.screenHeight(context) * 0.02,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Last Date 25/08/25',
                      style: TextStyle(fontSize: ResponsiveConstants.screenWidth(context) * 0.03, color: AppColors.white),
                    ),
                  ],
                ),
              ],
            ),
            CustomFakeButton(buttonTitle: 'View All'),
          ],
        ),
      ),
    );
  }
}
