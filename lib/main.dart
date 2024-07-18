import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './router/router.dart';
import './constant/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final router = useState<GoRouter?>(null); // GoRouterのインスタンス// null許容

    // ルーター再取得
    Future<void> updateRouter() async {
      final newRouter = await createRouter(updateRouter: updateRouter); // 非同期でルーターを取得
      router.value = newRouter; // 取得したルーターを状態にセット
    }

    // ルーターの初期化を非同期で行う
    Future<void> initializeRouter() async {
      final getRouter = await createRouter(updateRouter: updateRouter); // 非同期でルーターを取得
      router.value = getRouter; // 取得したルーターを状態にセット
    }

    useEffect(() {
      // 直接非同期関数を書くことはできない
      initializeRouter();
      return () {};
    }, []);

    if (router.value == null) {
      // ルーターが初期化されていない場合、ローディングインジケーターを表示
      return const Center(child: CircularProgressIndicator());
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false, //デバッグの表示を消す
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.main, 
          iconTheme: IconThemeData(color: AppColors.iconLight),
        ),
      ),
      // ルーティングの設定
      routerConfig: router.value,
    );
  }
}
