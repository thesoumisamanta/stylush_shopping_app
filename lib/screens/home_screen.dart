import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/models/fake_store_model.dart';
import 'package:stylush_shopping_app/models/products_model.dart';
import 'package:stylush_shopping_app/screens/profile_screen.dart';
import 'package:stylush_shopping_app/screens/trending_products_screen.dart';
import 'package:stylush_shopping_app/services/api_services.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/bumper_offers_card.dart';
import 'package:stylush_shopping_app/widgets/custom_search_bar.dart';
import 'package:stylush_shopping_app/widgets/deal_of_the_day_card.dart';
import 'package:stylush_shopping_app/widgets/high_heels_card.dart';
import 'package:stylush_shopping_app/widgets/hot_summer_sale_card.dart';
import 'package:stylush_shopping_app/widgets/offer_card.dart';
import 'package:stylush_shopping_app/widgets/product_card.dart';
import 'package:stylush_shopping_app/widgets/product_category_list.dart';
import 'package:stylush_shopping_app/widgets/small_product_card.dart';
import 'package:stylush_shopping_app/widgets/sponsered_card.dart';
import 'package:stylush_shopping_app/widgets/trending_products_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();
  List<FakeStoreModel> products = [];
  List<ProductsModel> dummyProducts = [];
  bool isPageLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    try {
      setState(() {
        isPageLoading = true;
        errorMessage = null;
      });

      final results = await Future.wait([
        _apiServices.fetchFakeStoreProducts(),
        _apiServices.getDummyProducts(),
      ]);

      setState(() {
        products = results[0] as List<FakeStoreModel>;
        dummyProducts = results[1] as List<ProductsModel>;
        isPageLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isPageLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _loadAllData();
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.orange, strokeWidth: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: AppColors.grey),
              SizedBox(height: 20),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: ResponsiveConstants.screenWidth(context) * 0.05,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                errorMessage ?? 'Please check your internet connection',
                style: TextStyle(
                  fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _refreshData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Stylush',
          style: TextStyle(
            fontSize: ResponsiveConstants.screenWidth(context) * 0.05,
            fontWeight: FontWeight.bold,
            color: AppColors.orange,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/hamburgar_menu.svg',
            height: ResponsiveConstants.screenHeight(context) * 0.03,
          ),
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
            icon: Icon(
              Icons.person_2_rounded,
              size: ResponsiveConstants.screenHeight(context) * 0.03,
            ),
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppColors.orange,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveConstants.screenWidth(context) * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: CustomSearchBar()),
                    SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/image_picker.svg',
                      height: ResponsiveConstants.screenHeight(context) * 0.03,
                      colorFilter: ColorFilter.mode(
                        AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                SizedBox(
                  height: ResponsiveConstants.screenWidth(context) * 0.22,
                  child: Card(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: ProductCategoryList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrendingProductsScreen(),
                        ),
                      ),
                  child: OfferCard(),
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrendingProductsScreen(),
                        ),
                      ),
                  child: DealOfTheDayCard(),
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  color: AppColors.orange6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            'Trending Products',
                            style: TextStyle(
                              fontSize:
                                  ResponsiveConstants.screenWidth(context) *
                                  0.04,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                products
                                    .map(
                                      (product) =>
                                          ProductCard(product: product),
                                    )
                                    .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                BumperOffersCard(),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                HighHeelsCard(),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                TrendingProductsCard(),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                HotSummerSaleCard(),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  color: AppColors.orange6,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ResponsiveConstants.screenHeight(context) * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            'Lowest Prices Products',
                            style: TextStyle(
                              fontSize:
                                  ResponsiveConstants.screenWidth(context) *
                                  0.05,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                dummyProducts
                                    .map(
                                      (dummyProduct) => SmallProductCard(
                                        products: dummyProduct,
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
                SponseredCard(),
                SizedBox(
                  height: ResponsiveConstants.screenHeight(context) * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg', height: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/wishlist.svg', height: 30),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cart.svg', height: 40),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/search.svg', height: 30),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/settings.svg', height: 30),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isPageLoading) {
      return _buildLoadingScreen();
    }

    if (errorMessage != null) {
      return _buildErrorScreen();
    }

    return _buildMainContent();
  }
}
