import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/custom_fake_button.dart';

class HighHeelsCard extends StatelessWidget {
  const HighHeelsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/high_heels.png',
            height: ResponsiveConstants.screenHeight(context) * 0.25,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveConstants.screenWidth(context) * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Text(
                    'Flat and Heels',
                    style: TextStyle(fontSize: ResponsiveConstants.screenWidth(context) * 0.05, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Stand a chance to get rewarded',
                    style: TextStyle(fontSize: ResponsiveConstants.screenWidth(context) * 0.03,),
                    softWrap: true, 
                    overflow: TextOverflow.visible, 
                  ),
                  SizedBox(height: ResponsiveConstants.screenHeight(context) * 0.05,),
                  CustomFakeButton(
                    buttonTitle: 'Visit Now',
                    bgColor: AppColors.orange3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
