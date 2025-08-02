import 'package:flutter/material.dart';
import 'package:flutter_image_filters/pick_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filter Snap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange.shade100,
        ),
      ),
      home: PickImageScreen(),
    );
  }
}
