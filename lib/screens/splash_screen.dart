import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/controllers/splash_controller.dart';
import 'package:stylush_shopping_app/screens/app_tour.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SplashController _splashController;

  @override
  void initState() {
    super.initState();
    _splashController = SplashController(vsync: this);
    _splashController.startAnimation();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 7));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AppTour()),
      );
    }
  }

  @override
  void dispose() {
    _splashController.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _splashController.slideController,
              builder: (context, child) {
                return SlideTransition(
                  position: _splashController.slideAnimation,
                  child: Transform.translate(
                    offset: Offset(0, _splashController.bounceAnimation.value),
                    child: Image.asset('assets/images/stylush_bag.png'),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            AnimatedBuilder(
              animation: _splashController.slideController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _splashController.slideController,
                    curve: Interval(
                      0.5,
                      0.7,
                      curve: Curves.easeIn,
                    ), // Appears during bouncing
                  ),
                  child: AnimatedBuilder(
                    animation: _splashController.textController,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.white,
                              AppColors.white,
                              AppColors.green,
                              AppColors.yellow,
                              AppColors.blue,
                              AppColors.green,
                              AppColors.white,
                              AppColors.white,
                            ],
                            stops: [
                              0.0,
                              (_splashController.gradientAnimation.value - 0.3)
                                  .clamp(0.0, 1.0),
                              (_splashController.gradientAnimation.value - 0.2)
                                  .clamp(0.0, 1.0),
                              _splashController.gradientAnimation.value.clamp(
                                0.0,
                                1.0,
                              ),
                              (_splashController.gradientAnimation.value + 0.1)
                                  .clamp(0.0, 1.0),
                              (_splashController.gradientAnimation.value + 0.2)
                                  .clamp(0.0, 1.0),
                              (_splashController.gradientAnimation.value + 0.3)
                                  .clamp(0.0, 1.0),
                              1.0,
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Stylush',
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
