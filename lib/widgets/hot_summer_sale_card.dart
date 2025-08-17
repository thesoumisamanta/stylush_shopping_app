import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/custom_fake_button.dart';

class HotSummerSaleCard extends StatelessWidget {
  const HotSummerSaleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset('assets/images/hot_summer_sale.png'),
            SizedBox(height: ResponsiveConstants.screenHeight(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Arrivals',
                      style: TextStyle(
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.045,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Summer' 25 Collections",
                      style: TextStyle(fontSize: ResponsiveConstants.screenWidth(context) * 0.035, color: AppColors.black),
                    ),
                  ],
                ),
                CustomFakeButton(
                  buttonTitle: 'View All',
                  bgColor: AppColors.orange2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
