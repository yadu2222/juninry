import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// デフォルトで表示しているウィジェット
import '../view/components/organism/basic_view.dart';
// 各ユーザータイプのルーター
import 'junior_branch.dart';
import 'patron_branch.dart';
import 'teacher_branch.dart';

// sample
import '../constant/sample_data.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

Future<GoRouter> createRouter() async {
  // final userService = UserService();
  // final userRole = await userService.getUserRole();

  // ユーザータイプに合わせたbranchesを返す
  final userRole = SampleData.user.userTypeId;
  List<StatefulShellBranch> getRouter() {
    if (userRole == 0) {
      return JuniorBranch.juniorBranch;
    } else if (userRole == 1) {
      return PatronBranch.patronBranch;
    } else if (userRole == 2) {
      return TeacherBranch.teacherBranch;
    } else {
      return [];
    }
  }

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: [
      // ボトムバーが必要な画面のルーティング
      // いらなければ StatefulShellRoute と同じ階層に GoRoute で書く
      StatefulShellRoute.indexedStack(
          // parentNavigatorKey: rootNavigatorKey,    // これがあると初期画面で/homeにたどり着けない 原因究明中
          // ここで常時表示させたいクラスをビルドしている
          builder: (context, state, navigationShell) {
            return BasicScreenView(navigationShell: navigationShell);
          },
          branches: [...getRouter()])
    ],
  );
}
