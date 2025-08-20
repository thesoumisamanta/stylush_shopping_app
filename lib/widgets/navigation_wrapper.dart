import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/screens/home_screen.dart';
import 'package:stylush_shopping_app/screens/profile_screen.dart';
import 'package:stylush_shopping_app/screens/trending_products_screen.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/bottom_nav_item.dart';
import 'package:stylush_shopping_app/widgets/custom_bottom_nav_bar.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TrendingProductsScreen(), 
    const ProfileScreen(),          
    Center(child: Text("Orders Screen")),
    Center(child: Text("Settings Screen")),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        items: [
          BottomNavItem(
            label: "Home",
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: ResponsiveConstants.screenWidth(context) * 0.06,
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? AppColors.orange : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => _onTabSelected(0),
            isActive: _currentIndex == 0,
          ),
          BottomNavItem(
            label: "Wishlist",
            icon: SvgPicture.asset(
              'assets/icons/wishlist.svg',
              height: ResponsiveConstants.screenWidth(context) * 0.06,
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? AppColors.orange : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => _onTabSelected(1),
            isActive: _currentIndex == 1,
          ),
          BottomNavItem(
            label: "Cart",
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              height: ResponsiveConstants.screenWidth(context) * 0.06,
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? AppColors.orange : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => _onTabSelected(2),
            isActive: _currentIndex == 2,
          ),
          BottomNavItem(
            label: "Orders",
            icon: SvgPicture.asset(
              'assets/icons/order_bag.svg',
              height: ResponsiveConstants.screenWidth(context) * 0.06,
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? AppColors.orange : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => _onTabSelected(3),
            isActive: _currentIndex == 3,
          ),
          BottomNavItem(
            label: "Settings",
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: ResponsiveConstants.screenWidth(context) * 0.06,
              colorFilter: ColorFilter.mode(
                _currentIndex == 4 ? AppColors.orange : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => _onTabSelected(4),
            isActive: _currentIndex == 4,
          ),
        ],
      ),
    );
  }
}
