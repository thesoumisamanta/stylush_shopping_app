import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylush_shopping_app/widgets/custom_search_bar.dart';

class TrendingProductsScreen extends StatefulWidget {
  const TrendingProductsScreen({super.key});

  @override
  State<TrendingProductsScreen> createState() => _TrendingProductsScreenState();
}

class _TrendingProductsScreenState extends State<TrendingProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/back_arrow.svg',
                  height: 24,
                  width: 24,
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: CustomSearchBar(height: 40,),
              )),
            ],
          ),
        ),

        // title: CustomSearchBar(height: 40,),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: SvgPicture.asset('assets/icons/back_arrow.svg', height: 24, width: 24,),
        // ),
        // titleSpacing: 0,
      ),
    );
  }
}
