import 'package:flutter/material.dart';
import 'views/image_galary_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'Image List Screen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ImageGalleryView(title: 'Image List Screen',),
      debugShowCheckedModeBanner: false
    );
  }
}
