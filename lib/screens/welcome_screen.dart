import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/screens/home_screen.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/utils/slide_page_route.dart';
import 'package:stylush_shopping_app/widgets/auto_sliding_page_view.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> images = [
    "assets/images/welcome1.jpg",
    "assets/images/welcome2.jpg",
    "assets/images/welcome3.jpg",
    "assets/images/welcome4.jpg",
    "assets/images/welcome5.jpg",
    "assets/images/welcome6.jpg",
  ];

  void _navigateToHome() {
    SlideNavigation.pushReplacement(
      context,
      HomeScreen(),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AutoSlidingPageView(
            slideDuration: Duration(seconds: 2),
            animationDuration: Duration(milliseconds: 500),
            enableInfiniteLoop: true,
            allowUserScroll: false,
            children:
                images
                    .map(
                      (imagePath) => Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                    .toList(),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withAlpha(500), Colors.transparent],
                  stops: [0, 0.7],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width * 0.15,
            right: MediaQuery.of(context).size.width * 0.15,
            child: Column(
              children: [
                Text(
                  "Stylush will make you Stylish",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveConstants.screenWidth(context) * 0.07,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Find it here, Buy it now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveConstants.screenWidth(context) * 0.03,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.04,
                ),
                ElevatedButton(
                  onPressed: _navigateToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: Size(
                      double.infinity,
                      ResponsiveConstants.screenHeight(context) * 0.06,
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
