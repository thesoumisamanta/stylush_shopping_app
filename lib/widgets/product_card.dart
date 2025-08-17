import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/models/fake_store_model.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class ProductCard extends StatelessWidget {
  final FakeStoreModel product;
  const ProductCard({super.key, required this.product});

  String cleanText(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: (MediaQuery.of(context).size.width - 44) / 3,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image!, height: 80, width: 80,),
            SizedBox(height: 8),
            Text(
              cleanText(product.title!),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              cleanText(product.description!),
              style: TextStyle(fontSize: 10, color: AppColors.black),
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/rupee.svg',
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                  height: 9,
                  width: 9,
                ),
                Text(
                  product.price!.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            RatingBarIndicator(
              itemBuilder:
                  (context, _) => Icon(Icons.star, color: AppColors.yellow2),
              itemSize: 15,
              rating: product.rating ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
