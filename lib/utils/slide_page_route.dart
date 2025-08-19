import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  SlidePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Right to Left slide animation
            const begin = Offset(1.0, 0.0);  // Start from right
            const end = Offset.zero;          // End at center
            
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween.chain(
              CurveTween(curve: curve),
            ));

            // Optional: Add fade transition for smoother effect
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
            ));

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );
}

// Extension method for easy navigation
extension NavigatorExtension on NavigatorState {
  Future<T?> pushSlide<T extends Object?>(Widget page) {
    return push<T>(SlidePageRoute<T>(child: page));
  }

  Future<T?> pushReplacementSlide<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return pushReplacement<T, TO>(
      SlidePageRoute<T>(child: page),
      result: result,
    );
  }
}

// Static helper methods for direct usage
class SlideNavigation {
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.of(context).push<T>(
      SlidePageRoute<T>(
        child: page,
        duration: duration,
        curve: curve,
      ),
    );
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    TO? result,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.of(context).pushReplacement<T, TO>(
      SlidePageRoute<T>(
        child: page,
        duration: duration,
        curve: curve,
      ),
      result: result,
    );
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page,
    bool Function(Route<dynamic>) predicate, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      SlidePageRoute<T>(
        child: page,
        duration: duration,
        curve: curve,
      ),
      predicate,
    );
  }
}