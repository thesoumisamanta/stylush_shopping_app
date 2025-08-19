import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/auto_sliding_page_view.dart';

class SponseredCard extends StatefulWidget {
  const SponseredCard({super.key});

  @override
  State<SponseredCard> createState() => _SponseredCardState();
}

class _SponseredCardState extends State<SponseredCard> {
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/nike_shoe.png',
      'off': '50% off',
      'caption': 'Up to 50% off on Nike Shoes',
    },
    {
      'image': 'assets/images/mamaearth_beauties.png',
      'off': '30% off',
      'caption': 'Up to 30% off on Mamaearth ',
    },
    {
      'image': 'assets/images/ladies_jeans.png',
      'off': '10% off',
      'caption': 'Up to 10% off on Ladies Jeans',
    },
    {
      'image': 'assets/images/oxidise_jwellary.png',
      'off': '40% off',
      'caption': 'Up to 30% off on Oxidise Jwellary',
    },
    {
      'image': 'assets/images/ladies_bags.png',
      'off': '20% off',
      'caption': 'Up to 30% off on Ladies Bags',
    },
  ];

  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveConstants.screenWidth(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sponsered',
              style: TextStyle(
                fontSize: ResponsiveConstants.screenWidth(context) * 0.05,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            AutoSlidingPageView(
              height: ResponsiveConstants.screenHeight(context) * 0.25,
              slideDuration: Duration(seconds: 2),
              animationDuration: Duration(milliseconds: 500),
              enableInfiniteLoop: true,
              allowUserScroll: false,
              onPageChanged: (index) {
                setState(() {
                  _currentSlide = index;
                });
              },
              children:
                  _slides
                      .map(
                        (slide) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                slide['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Center(
                              child: Text(
                                slide['off']!,
                                style: TextStyle(
                                  fontSize:
                                      ResponsiveConstants.screenWidth(context) *
                                      0.08,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 10),
            Text(
              _slides[_currentSlide]['caption']!,
              style: TextStyle(
                fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
