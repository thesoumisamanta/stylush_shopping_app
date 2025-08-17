import 'package:flutter/material.dart';
import 'package:stylush_shopping_app/constants/responsive_constants.dart';
import 'package:stylush_shopping_app/themes/app_colors.dart';

class ProductCategoryList extends StatelessWidget {
  const ProductCategoryList({super.key});
  final List<Map<String, String>> categories = const [
    {
      "name": "Clothing",
      "image": "https://cdn-icons-png.flaticon.com/512/892/892458.png",
    },
    {
      "name": "Shoes",
      "image": "https://cdn-icons-png.flaticon.com/512/3144/3144456.png",
    },
    {
      "name": "Beauty",
      "image": "https://cdn-icons-png.flaticon.com/512/1867/1867062.png",
    },
    {
      "name": "Sports",
      "image": "https://cdn-icons-png.flaticon.com/512/1165/1165787.png",
    },
    {
      "name": "Sports",
      "image": "https://cdn-icons-png.flaticon.com/512/1165/1165787.png",
    },
    {
      "name": "Sports",
      "image": "https://cdn-icons-png.flaticon.com/512/1165/1165787.png",
    },
    {
      "name": "Sports",
      "image": "https://cdn-icons-png.flaticon.com/512/1165/1165787.png",
    },
    {
      "name": "Sports",
      "image": "https://cdn-icons-png.flaticon.com/512/1165/1165787.png",
    },
    {
      "name": "Sports",
      "image": "https://cdn-icons-png.flaticon.com/512/1165/1165787.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            right: ResponsiveConstants.screenWidth(context) * 0.03,
            left: ResponsiveConstants.screenWidth(context) * 0.03,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: ResponsiveConstants.screenWidth(context) * 0.06,
                backgroundColor: AppColors.orange2.withAlpha(50),
                child: Image.network(
                  categories[index]["image"]!,
                  width: ResponsiveConstants.screenWidth(context) * 0.075,
                  height: ResponsiveConstants.screenWidth(context) * 0.075,
                ),
              ),
              SizedBox(
                height: ResponsiveConstants.screenHeight(context) * 0.01,
              ),
              Text(
                categories[index]["name"]!,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: ResponsiveConstants.screenWidth(context) * 0.025,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
