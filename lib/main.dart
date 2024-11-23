import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './router/router.dart';
import './constant/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final router = useState<GoRouter?>(null); // GoRouterのインスタンス// null許容

    // ルーターの初期化を非同期で行う
    Future<void> initializeRouter() async {
      final getRouter = await createRouter(updateRouter: initializeRouter); // 非同期でルーターを取得
      router.value = getRouter; // 取得したルーターを状態にセット
    }

    useEffect(() {
      // 直接非同期関数を書くことはできない
      initializeRouter();
      return () {};
    }, []);

    return router.value == null
        ? const Center(child: CircularProgressIndicator())
        : MaterialApp.router(
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
