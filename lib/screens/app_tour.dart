import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/screens/welcome_screen.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class AppTour extends StatefulWidget {
  const AppTour({super.key});

  @override
  State<AppTour> createState() => _AppTourState();
}

class _AppTourState extends State<AppTour> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int newpage = _pageController.page?.round() ?? 0;
      if (newpage != _currentPage) {
        setState(() {
          _currentPage = newpage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_currentPage != 5)
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => WelcomeScreen()),
                );
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              child: Text(
                "Skip",
                style: TextStyle(
                  fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            )
          else
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => WelcomeScreen()),
                );
              },
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange2,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveConstants.screenWidth(context) * 0.04,
                ),
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildPage(
                      img: "assets/images/choose_products.png",
                      title: "Choose Product",
                      description:
                          "Pick the items you like from many options and add them to your cart easily for a simple shopping experience.",
                    ),
                    _buildPage(
                      img: "assets/images/add_to_cart.png",
                      title: "Add To Cart",
                      description:
                          "Save your favorite products in the cart for a faster, easier, and more convenient checkout experience.",
                    ),
                    _buildPage(
                      img: "assets/images/make_payments.png",
                      title: "Make Payments",
                      description:
                          "Complete your purchase quickly and securely with multiple payment options, including cards, UPI, wallets, and more, ensuring a safe and hassle-free checkout experience every time you shop.",
                    ),
                    _buildPage(
                      img: "assets/images/fast_delivery.png",
                      title: "Fastest Delivery",
                      description:
                          "Get your orders delivered to your doorstep quickly with our reliable and fast delivery service, ensuring you receive products on time without any hassle.",
                    ),
                    _buildPage(
                      img: "assets/images/track_order.png",
                      title: "Track Your Delivery",
                      description:
                          "Stay updated on your purchase with real-time order tracking, from dispatch to delivery, so you always know where your package is.",
                    ),
                    _buildPage(
                      img: 'assets/images/easy_returns.png',
                      title: "Easy Returns",
                      description:
                          "Enjoy a hassle-free return process with simple steps and quick refunds, making it easy to return products that don’t meet your expectations.",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 6,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.orange2,
                dotHeight: ResponsiveConstants.screenWidth(context) * 0.02,
                dotWidth: ResponsiveConstants.screenWidth(context) * 0.02,
              ),
            ),
          ),
          SizedBox(height: ResponsiveConstants.screenHeight(context) * 0.015),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String img,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: ResponsiveConstants.screenHeight(context) * 0.35,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveConstants.screenWidth(context) * 0.055,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
            fontWeight: FontWeight.bold,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
