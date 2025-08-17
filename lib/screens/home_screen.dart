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
  bool isLoading = true;
  bool isDummyLoading = true;
  String? errorMessage;

  Future<void> fetchFakeStroreProducts() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      final data = await _apiServices.fetchFakeStoreProducts();
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> fetchDummyProducts() async {
    try {
      setState(() {
        isDummyLoading = true;
        errorMessage = null;
      });
      final data = await _apiServices.getDummyProducts();
      setState(() {
        dummyProducts = data;
        isDummyLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isDummyLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFakeStroreProducts();
    fetchDummyProducts();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                height: ResponsiveConstants.screenHeight(context) * 0.14,
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
                onTap: () => TrendingProductsScreen(),
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
                                ResponsiveConstants.screenWidth(context) * 0.04,

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
                                        isLoading
                                            ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.orange,
                                              ),
                                            )
                                            : ProductCard(product: product),
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
                  padding:  EdgeInsets.only(top: ResponsiveConstants.screenHeight(context) * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'Lowest Prices Products',
                          style: TextStyle(
                            fontSize: ResponsiveConstants.screenWidth(context) * 0.05,
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
                                    (dummyProduct) =>
                                        isLoading
                                            ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.orange,
                                              ),
                                            )
                                            : SmallProductCard(
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
      bottomNavigationBar: BottomNavigationBar(
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
}
