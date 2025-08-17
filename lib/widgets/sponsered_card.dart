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
  late PageController _overlayTextController;
  late PageController _captionTextController;
  
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

  List<Map<String, String>> _extendedSlides = [];

  @override
  void initState() {
    super.initState();

    _extendedSlides = [..._slides, _slides[0]];

    _pageController = PageController(initialPage: 0);
    _overlayTextController = PageController(initialPage: 0);
    _captionTextController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        _animateToNextSlide();
      }
    });
  }

  void _animateToNextSlide() {
    _currentPage++;
    
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    
    Future.delayed(Duration(milliseconds: 400), () {
      if (_overlayTextController.hasClients) {
        _overlayTextController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
    
    Future.delayed(Duration(milliseconds: 100), () {
      if (_captionTextController.hasClients) {
        _captionTextController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handlePageChange(int index) {
    if (index == _extendedSlides.length - 1) {
      Future.delayed(Duration(milliseconds: 500), () {
        _pageController.jumpToPage(0);
        _overlayTextController.jumpToPage(0);
        _captionTextController.jumpToPage(0);
        setState(() {
          _currentPage = 0;
        });
      });
    } else {
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _overlayTextController.dispose();
    _captionTextController.dispose();
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
                // Image PageView
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.25,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _extendedSlides.length,
                    onPageChanged: _handlePageChange,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _extendedSlides[index]['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: PageView.builder(
                    controller: _overlayTextController,
                    itemCount: _extendedSlides.length,
                    physics: NeverScrollableScrollPhysics(), 
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          _extendedSlides[index]['off']!,
                          style: TextStyle(
                            fontSize: ResponsiveConstants.screenWidth(context) * 0.08,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 4.0,
                                color: Colors.black.withValues(alpha: 0.5),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Caption text PageView
            SizedBox(
              height: ResponsiveConstants.screenWidth(context) * 0.06, 
              child: PageView.builder(
                controller: _captionTextController,
                itemCount: _extendedSlides.length,
                physics: NeverScrollableScrollPhysics(), 
                itemBuilder: (context, index) {
                  return Text(
                    _extendedSlides[index]['caption']!,
                    style: TextStyle(
                      fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}