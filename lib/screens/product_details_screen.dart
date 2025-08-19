import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/provider/product_provider.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';
import 'package:stylush_shopping_app/widgets/custom_snack_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();
  final ScrollController _imageScrollController = ScrollController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _imageScrollController.dispose();
    super.dispose();
  }

  void _onImageTap(int index, int totalImages) {
    setState(() {
      _currentImageIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _scrollToSelectedImage(index, totalImages);
  }

  void _scrollToSelectedImage(int index, int totalImages) {
    if (!_imageScrollController.hasClients) return;

    const double itemWidth = 112.0;
    final double maxScroll = _imageScrollController.position.maxScrollExtent;
    final double viewportWidth =
        _imageScrollController.position.viewportDimension;

    double targetScroll =
        (index * itemWidth) - (viewportWidth / 2) + (itemWidth / 2);

    targetScroll = targetScroll.clamp(0.0, maxScroll);

    _imageScrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 1,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
            ],
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final product = productProvider.selectedProduct;
          final discountedPrice =
              (product != null &&
                      product.price != null &&
                      product.discountPercentage != null)
                  ? product.price! * (1 - (product.discountPercentage! / 100))
                  : null;

          if (product == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<String> imageUrls =
              product.images?.isNotEmpty == true
                  ? product.images!
                  : [product.thumbnail ?? ''];

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: ResponsiveConstants.screenHeight(context) * 0.4,
                  width: double.infinity,
                  color: AppColors.white,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                          _scrollToSelectedImage(index, imageUrls.length);
                        },
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                      if (imageUrls.length > 1)
                        Positioned(
                          bottom: ResponsiveConstants.screenHeight(context) * 0.01,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: imageUrls.length,
                              effect: WormEffect(
                                dotHeight:
                                    ResponsiveConstants.screenWidth(context) *
                                    0.02,
                                dotWidth:
                                    ResponsiveConstants.screenWidth(context) *
                                    0.02,
                                spacing:
                                    ResponsiveConstants.screenWidth(context) *
                                    0.02,
                                activeDotColor: AppColors.orange,
                                dotColor: AppColors.grey.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        style: TextStyle(
                          fontSize:
                              ResponsiveConstants.screenWidth(context) * 0.04,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        height:
                            ResponsiveConstants.screenHeight(context) * 0.004,
                      ),
                      Text(
                        product.description!,
                        style: TextStyle(
                          fontSize:
                              ResponsiveConstants.screenWidth(context) * 0.03,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        height:
                            ResponsiveConstants.screenHeight(context) * 0.02,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.orange.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          product.category!,
                          style: TextStyle(
                            fontSize:
                                ResponsiveConstants.screenWidth(context) *
                                0.032,
                            color: AppColors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            ResponsiveConstants.screenHeight(context) * 0.015,
                      ),

                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/rupee.svg',
                                colorFilter: ColorFilter.mode(
                                  AppColors.black,
                                  BlendMode.srcIn,
                                ),
                                height:
                                    ResponsiveConstants.screenWidth(context) *
                                    0.04,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                discountedPrice!.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize:
                                      ResponsiveConstants.screenWidth(context) *
                                      0.055,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '₹${product.price?.toStringAsFixed(0) ?? ''}',
                            style: TextStyle(
                              fontSize:
                                  ResponsiveConstants.screenWidth(context) *
                                  0.04,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${product.discountPercentage?.round() ?? 0}% off",
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize:
                                  ResponsiveConstants.screenWidth(context) *
                                  0.035,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      if (imageUrls.length > 1) ...[
                        Text(
                          'Product Images',
                          style: TextStyle(
                            fontSize:
                                ResponsiveConstants.screenWidth(context) *
                                0.042,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height:
                              ResponsiveConstants.screenHeight(context) * 0.12,
                          child: ListView.builder(
                            controller: _imageScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index) {
                              final bool isSelected =
                                  index == _currentImageIndex;
                              return GestureDetector(
                                onTap:
                                    () => _onImageTap(index, imageUrls.length),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width:
                                      ResponsiveConstants.screenHeight(
                                        context,
                                      ) *
                                      0.12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? AppColors.orange
                                              : AppColors.grey.withValues(
                                                alpha: 0.3,
                                              ),
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrls[index],
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: AppColors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveConstants.screenWidth(context) * 0.025,
          vertical: ResponsiveConstants.screenWidth(context) * 0.005,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  CustomSnackBar.show(
                    context,
                    message: "Item added to cart",
                    backgroundColor: AppColors.orange,
                    icon: Icons.check_circle,
                    height: ResponsiveConstants.screenHeight(context) * 0.06,
                    borderRadius: 6,
                    duration: Duration(seconds: 4),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveConstants.screenWidth(context) * 0.025,
                  ),
                  minimumSize: Size(
                    double.infinity,
                    ResponsiveConstants.screenWidth(context) * 0.04,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: ResponsiveConstants.screenWidth(context) * 0.04),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange),
                borderRadius: BorderRadius.circular(6),
              ),
              height: ResponsiveConstants.screenWidth(context) * 0.1,
              width: ResponsiveConstants.screenWidth(context) * 0.1,
              child: IconButton(
                onPressed: () {
                  CustomSnackBar.show(
                    context,
                    message: "Item added to wishlist",
                    backgroundColor: AppColors.orange,
                    icon: Icons.check_circle,
                    height: ResponsiveConstants.screenHeight(context) * 0.06,
                    borderRadius: 6,
                    duration: Duration(seconds: 4),
                  );
                },
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.orange,
                  size: ResponsiveConstants.screenWidth(context) * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
