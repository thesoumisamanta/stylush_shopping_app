import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/models/products_model.dart';
import 'package:stylush_shopping_app/provider/product_provider.dart';
import 'package:stylush_shopping_app/screens/product_details_screen.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/utils/slide_page_route.dart';
import 'package:stylush_shopping_app/widgets/custom_search_bar.dart';
import 'package:stylush_shopping_app/widgets/small_product_card.dart';

class TrendingProductsScreen extends StatefulWidget {
  const TrendingProductsScreen({super.key});

  @override
  State<TrendingProductsScreen> createState() => _TrendingProductsScreenState();
}

class _TrendingProductsScreenState extends State<TrendingProductsScreen> {
  List<ProductsModel> filteredProducts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      if (provider.dummyProducts.isNotEmpty) {
        setState(() {
          filteredProducts = provider.dummyProducts;
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final provider = context.read<ProductProvider>();
    setState(() {
      if (query.isEmpty) {
        filteredProducts = provider.dummyProducts;
      } else {
        filteredProducts =
            provider.dummyProducts.where((product) {
              final titleMatch = product.title!.toLowerCase().contains(
                query.toLowerCase(),
              );

              final categoryMatch = product.category!.toLowerCase().contains(
                query.toLowerCase(),
              );
              return titleMatch || categoryMatch;
            }).toList();
      }
    });
  }

  void _onProductTap(ProductsModel product) {
    context.read<ProductProvider>().setSelectedProduct(product);

    _navigateToProductDetailsScreen();
  }

  void _navigateToProductDetailsScreen() {
    SlideNavigation.push(
      context,
      ProductDetailsScreen(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.grey.shade100,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/back_arrow.svg',
                  height: ResponsiveConstants.screenWidth(context) * 0.05,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CustomSearchBar(
                    height: ResponsiveConstants.screenHeight(context) * 0.05,
                    hintText: 'Search any product',
                    onChanged: _onSearchChanged,
                    searchController: searchController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.orange,
                strokeWidth: 3,
              ),
            );
          }

          if (productProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: AppColors.grey),
                    SizedBox(height: 20),
                    Text(
                      'Failed to load products',
                      style: TextStyle(
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => productProvider.refreshData(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        foregroundColor: AppColors.white,
                      ),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (filteredProducts.isEmpty && searchController.text.isEmpty) {
            filteredProducts = productProvider.dummyProducts;
          }

          if (filteredProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: ResponsiveConstants.screenWidth(context) * 0.04,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Trending Products',
                      style: TextStyle(
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.05,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${filteredProducts.length} items',
                      style: TextStyle(
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.035,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.80,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onProductTap(filteredProducts[index]),
                        child: SmallProductCard(
                          products: filteredProducts[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
