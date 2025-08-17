import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class SponseredCard extends StatefulWidget {
  const SponseredCard({super.key});

  @override
  State<SponseredCard> createState() => _SponseredCardState();
}

class _SponseredCardState extends State<SponseredCard> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

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

  @override
  void initState() {
    super.initState();

    _slides.add(_slides[0]);

    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

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
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 5),
            Stack(
              children: [
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.25,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (index) {
                      if (index == _slides.length - 1) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          _pageController.jumpToPage(0);
                        });
                        _currentPage = 0;
                      } else {
                        setState(() {
                          _currentPage = index;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        child: Image.asset(
                          _slides[index]['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Text(
                      _slides[_currentPage]['off']!,
                      style: TextStyle(
                        fontSize: ResponsiveConstants.screenWidth(context) * 0.08,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Text(
                _slides[_currentPage]['caption']!,
                key: ValueKey<String>(_slides[_currentPage]['caption']!),
                style: TextStyle(
                  fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
