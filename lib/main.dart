import 'package:flutter/material.dart';
import 'router/router.dart';
import 'package:go_router/go_router.dart';
import './constant/colors.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GoRouter? _router;  // GoRouterのインスタンス// null許容
  // ルーターの初期化を非同期で行う
  Future<void> _initializeRouter() async {
    final router = await createRouter(); // 非同期でルーターを取得
    setState(() {
      _router = router; // 取得したルーターを状態にセット
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeRouter();
  }

  @override
  Widget build(BuildContext context) {

      if (_router == null) {
      // ルーターが初期化されていない場合、ローディングインジケーターを表示
      return const CircularProgressIndicator();
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false, //デバッグの表示を消す
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.main, iconTheme: IconThemeData(color: AppColors.iconLight)),
      ),
      // ルーティングの設定
      routerConfig: _router!,
    );
  }
}

