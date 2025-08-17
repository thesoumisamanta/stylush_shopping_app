import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/custom_fake_button.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.orange4.withAlpha(200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(
                  left: ResponsiveConstants.screenWidth(context) * 0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '50-60% OFF',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Now available in every color',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.03,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomFakeButton(
                      buttonTitle: 'Shop Now',
                      width: ResponsiveConstants.screenWidth(context) * 0.28,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/stylush_girl.png'),
            ),
          ],
        ),
      ),
    );
  }
}
