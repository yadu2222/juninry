import 'package:flutter/material.dart';
import 'router/router.dart';
import './constant/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, //デバッグの表示を消す
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.main, iconTheme: IconThemeData(color: AppColors.iconLight)),
      ),
      // ルーティングの設定
      routerConfig: router,
    );
  }
}
