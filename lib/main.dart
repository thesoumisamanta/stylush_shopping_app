import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylush_shopping_app/provider/product_provider.dart';
import 'package:stylush_shopping_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
