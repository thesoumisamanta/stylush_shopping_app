import 'package:flutter/material.dart';

class SplashController with ChangeNotifier {
  late AnimationController animationController;
  late AnimationController textGradientController;
  late Animation<Offset> slideAnimation;
  late Animation<double> bounceAnimation;
  late Animation<double> gradientAnimation;

  // Getter to access the slide controller for AnimatedBuilder
  AnimationController get slideController => animationController;
  AnimationController get textController => textGradientController;

  SplashController({required TickerProvider vsync}) {
    // Much longer duration for clearly visible bounces
    animationController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 4000), // 4 seconds for slow, smooth animation
    );

    // Separate controller for continuous text gradient animation
    textGradientController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 3000), // Change this value to control speed
    );

    // Slide animation - image comes from top smoothly
    slideAnimation = Tween<Offset>(
      begin: Offset(0, -3), // Start higher for more dramatic entrance
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController, 
        curve: Interval(0.0, 0.25, curve: Curves.easeOutQuart), // Takes 25% of total time (1 second)
      ),
    );

    // Continuous gradient sliding animation for text
    gradientAnimation = Tween<double>(
      begin: -1.5, // Start closer to reduce gap
      end: 1.5,   // End closer to reduce gap
    ).animate(
      CurvedAnimation(
        parent: textGradientController,
        curve: Curves.linear, // Linear for consistent speed
      ),
    );

    // Slow, countable bouncing effect with clearly visible drops
    bounceAnimation = TweenSequence<double>([
      // First bounce - highest and slowest
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 25, // Slow up movement
      ),
      TweenSequenceItem(
        tween: Tween(begin: 100.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 25, // Slow down to ground
      ),
      
      // Pause briefly on ground
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 5, // Brief pause
      ),
      
      // Second bounce - medium height
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 70.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 20, // Up movement
      ),
      TweenSequenceItem(
        tween: Tween(begin: 70.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 20, // Down to ground
      ),
      
      // Pause briefly on ground
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 5, // Brief pause
      ),
      
      // Third bounce - smaller
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 40.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 15, // Up movement
      ),
      TweenSequenceItem(
        tween: Tween(begin: 40.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 15, // Down to ground
      ),
      
      // Pause briefly on ground
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 5, // Brief pause
      ),
      
      // Fourth bounce - smallest
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 15.0).chain(CurveTween(curve: Curves.easeOut)), 
        weight: 10, // Up movement
      ),
      TweenSequenceItem(
        tween: Tween(begin: 15.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), 
        weight: 10, // Down to ground
      ),
      
      // Final settle and stay
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0), 
        weight: 20, // Long final rest
      ),
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.25, 1.0, curve: Curves.linear), // Starts after slide, uses linear for precise timing
      ),
    );
  }

  void startAnimation() {
    animationController.forward();
    // Start the text gradient animation with delay and make it repeat
    Future.delayed(Duration(milliseconds: 1500), () {
      textGradientController.repeat();
    });
  }

  void disposeController() {
    animationController.dispose();
    textGradientController.dispose();
  }
}