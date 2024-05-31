import 'package:flutter/material.dart';
import './view/pages/junior/page_home.dart';
import './constant/colors.dart';

import 'view/components/organism/basic_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //デバッグの表示を消す
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
        useMaterial3: true,
      ),
      home: const PageHomeJunior(),
    );
  }
}
