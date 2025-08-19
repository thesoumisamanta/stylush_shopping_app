import 'dart:async';
import 'package:flutter/material.dart';

class AutoSlidingPageView extends StatefulWidget {
  final List<Widget> children;
  final Duration slideDuration;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool enableInfiniteLoop;
  final bool allowUserScroll;
  final void Function(int)? onPageChanged;
  final double? height;
  final double? width;

  const AutoSlidingPageView({
    super.key,
    required this.children,
    this.slideDuration = const Duration(seconds: 1),
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.enableInfiniteLoop = true,
    this.allowUserScroll = false,
    this.onPageChanged,
    this.height,
    this.width,
  });

  @override
  State<AutoSlidingPageView> createState() => _AutoSlidingPageViewState();
}

class _AutoSlidingPageViewState extends State<AutoSlidingPageView> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  List<Widget> _extendedChildren = [];

  @override
  void initState() {
    super.initState();

    if (widget.enableInfiniteLoop && widget.children.isNotEmpty) {
      _extendedChildren = [...widget.children, widget.children[0]];
    } else {
      _extendedChildren = widget.children;
    }

    _pageController = PageController(initialPage: 0);

    _startAutoSliding();
  }

  void _startAutoSliding() {
    _timer = Timer.periodic(widget.slideDuration, (timer) {
      if (_pageController.hasClients && _extendedChildren.isNotEmpty) {
        _animateToNextSlide();
      }
    });
  }

  void _animateToNextSlide() {
    if (widget.enableInfiniteLoop) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    } else {
      if (_currentPage < widget.children.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    }
  }

  void _handlePageChange(int index) {
    if (widget.enableInfiniteLoop && index == _extendedChildren.length - 1) {
      Future.delayed(widget.animationDuration, () {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(0);
          setState(() {
            _currentPage = 0;
          });
        }
      });
    } else {
      setState(() {
        _currentPage = index;
      });
    }

    if (widget.onPageChanged != null) {
      int realIndex =
          widget.enableInfiniteLoop && index == _extendedChildren.length - 1
              ? 0
              : index % widget.children.length;
      widget.onPageChanged!(realIndex);
    }
  }

  void pauseAutoSliding() {
    _timer?.cancel();
  }

  void resumeAutoSliding() {
    _timer?.cancel();
    _startAutoSliding();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_extendedChildren.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: PageView.builder(
        controller: _pageController,
        physics:
            widget.allowUserScroll
                ? const PageScrollPhysics()
                : const NeverScrollableScrollPhysics(),
        itemCount: _extendedChildren.length,
        onPageChanged: _handlePageChange,
        itemBuilder: (context, index) {
          return _extendedChildren[index];
        },
      ),
    );
  }
}
