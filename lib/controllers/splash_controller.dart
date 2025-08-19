import 'package:flutter/material.dart';

class SplashController with ChangeNotifier {
  late AnimationController animationController;
  late AnimationController textGradientController;
  late Animation<Offset> slideAnimation;
  late Animation<double> bounceAnimation;
  late Animation<double> gradientAnimation;

  AnimationController get slideController => animationController;
  AnimationController get textController => textGradientController;

  SplashController({required TickerProvider vsync}) {
    animationController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 4000), 
    );

    textGradientController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 3000), 
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, -3), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController, 
        curve: Interval(0.0, 0.25, curve: Curves.easeOutQuart), 
      ),
    );

    gradientAnimation = Tween<double>(
      begin: -1.5, 
      end: 1.5,   
    ).animate(
      CurvedAnimation(
        parent: textGradientController,
        curve: Curves.linear,
      ),
    );

    bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 25, 
      ),
      TweenSequenceItem(
        tween: Tween(begin: 100.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 25, 
      ),
      
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 5, 
      ),
      
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 70.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 70.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 20, 
      ),
      
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 5,
      ),
      
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 40.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 15, 
      ),
      TweenSequenceItem(
        tween: Tween(begin: 40.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 15, 
      ),
      
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 5, 
      ),
      
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 15.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 10, 
      ),
      TweenSequenceItem(
        tween: Tween(begin: 15.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 10, 
      ),
      
      // Final settle and stay
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 20, 
      ),
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.25, 1.0, curve: Curves.linear), 
      ),
    );
  }

  void startAnimation() {
    animationController.forward();
    Future.delayed(Duration(milliseconds: 1500), () {
      textGradientController.repeat();
    });
  }

  void disposeController() {
    animationController.dispose();
    textGradientController.dispose();
  }
}