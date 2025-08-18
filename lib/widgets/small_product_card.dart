import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/models/products_model.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class SmallProductCard extends StatelessWidget {
  final ProductsModel products;
  const SmallProductCard({super.key, required this.products});

  String limitWords(String text, int charLimit) {
    if (text.length <= charLimit) return text;
    return text.substring(0, charLimit);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveConstants.screenWidth(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              products.thumbnail!,
              height: ResponsiveConstants.screenWidth(context) * 0.35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  limitWords(products.title!, 15),
                  style: TextStyle(
                    fontSize: ResponsiveConstants.screenWidth(context) * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/rupee.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                      height: ResponsiveConstants.screenWidth(context) * 0.025,
                    ),
                    SizedBox(width: 2),
                    Text(
                      (products.price! *
                              (1 - (products.discountPercentage! / 100)))
                          .toStringAsFixed(2),
                      style: TextStyle(
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.03,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '₹${products.price?.toStringAsFixed(0) ?? ''}',
                      style: TextStyle(
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.03,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${products.discountPercentage?.round() ?? 0}% off",
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize:
                            ResponsiveConstants.screenWidth(context) * 0.03,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
