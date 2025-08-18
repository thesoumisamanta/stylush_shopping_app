import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/provider/product_provider.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class ProductDeatilsScreen extends StatelessWidget {
  const ProductDeatilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final product = productProvider.selectedProduct;
          final discountedPrice =
              (product != null &&
                      product.price != null &&
                      product.discountPercentage != null)
                  ? product.price! * (1 - (product.discountPercentage! / 100))
                  : null;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: ResponsiveConstants.screenHeight(context) * 0.4,
                  width: double.infinity,
                  color: AppColors.white,
                  child: Image.network(
                    product!.thumbnail!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: AppColors.grey,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? 'No Title',
                        style: TextStyle(
                          fontSize:
                              ResponsiveConstants.screenWidth(context) * 0.05,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 8),

                      Container(
                        padding: EdgeInsets.symmetric(
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
                          product.category ?? 'No Category',
                          style: TextStyle(
                            fontSize:
                                ResponsiveConstants.screenWidth(context) *
                                0.032,
                            color: AppColors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

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
                              SizedBox(width: 4),
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
                          SizedBox(width: 12),
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
                          SizedBox(width: 8),
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

                      SizedBox(height: 20),

                      if (product.images != null &&
                          product.images!.isNotEmpty) ...[
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
                        SizedBox(height: 12),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 12),
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.grey.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.images![index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: AppColors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                      ],

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Add to cart functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to cart!'),
                                    backgroundColor: AppColors.orange,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orange,
                                foregroundColor: AppColors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize:
                                      ResponsiveConstants.screenWidth(context) *
                                      0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.orange),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Add to wishlist functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to wishlist!'),
                                    backgroundColor: AppColors.orange,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: AppColors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
