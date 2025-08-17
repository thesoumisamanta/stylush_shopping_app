import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class BumperOffersCard extends StatelessWidget {
  const BumperOffersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding:  EdgeInsets.all(ResponsiveConstants.screenWidth(context) * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Image.asset(
              'assets/images/bumper_offer.png',
              height: ResponsiveConstants.screenHeight(context) * 0.12,                
            ),
             SizedBox(width: ResponsiveConstants.screenWidth(context) * 0.16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Row(
                    children: [
                       Text(
                        'Bumper Offers',
                        style: TextStyle(
                          fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(width: ResponsiveConstants.screenWidth(context) * 0.01),
                      CircleAvatar(
                        radius: ResponsiveConstants.screenWidth(context) * 0.03,
                        backgroundColor: AppColors.orange4.withAlpha(100),
                        child: Image.asset(
                          'assets/images/wow_emoji.png',
                          height: ResponsiveConstants.screenHeight(context) * 0.02,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), 
                   Text(
                    'We make sure you get the offer you need at best prices',
                    style: TextStyle(fontSize: ResponsiveConstants.screenWidth(context) * 0.03, color: AppColors.black),
                    softWrap: true, 
                    overflow: TextOverflow.visible, 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}