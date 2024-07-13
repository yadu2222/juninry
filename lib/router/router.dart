import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// デフォルトで表示しているウィジェット
import '../view/components/organism/basic_view.dart';
// 各ユーザータイプのルーター
import 'junior_branch.dart';
import 'patron_branch.dart';
import 'teacher_branch.dart';
// import 'debug_branch.dart'; // デバッグ用 すきにさわっていいよ gitから外してね

import '../view/pages/share/page_login.dart';
import '../view/pages/share/page_user_register.dart';

// sample
// import '../constant/sample_data.dart';
import '../models/user_model.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

// enumで宣言
enum BranchType {
  junior,
  patron,
  teacher,
}

// ひもづけ
extension BranchTypeExt on BranchType {
  List<StatefulShellBranch> get branch {
    switch (this) {
      case BranchType.teacher:
        return TeacherBranch.teacherBranchs;
      case BranchType.junior:
        return JuniorBranch.juniorBranchs;
      case BranchType.patron:
        return PatronBranch.patronBranchs;
    }
  }
}

Future<List<StatefulShellBranch>> getBranches() async {
  // ユーザータイプに合わせたbranchesを返す
  // dbから取得
  final int userRole = await User.getUser().then((value) => value.userTypeId);
  switch (userRole) {
    case 1:
      debugPrint('teacher');
      return BranchType.teacher.branch;
    case 2:
      debugPrint('junior');
      return BranchType.junior.branch;
    case 3:
      debugPrint('patron');
      return BranchType.patron.branch;
    default:
      debugPrint('error');
      return BranchType.junior.branch;
  }
}

// 特定のブランチかをチェックして返す
Future<bool> isBranch(BranchType branchType) async {
  final branches = await getBranches();
  return branches == branchType.branch;
}

class GoRouterUtil {
  late GoRouter router;

  static final GoRouterUtil _instance = GoRouterUtil._internal();
  GoRouterUtil._internal();

  // ファクトリコンストラクタ
  factory GoRouterUtil() {
    // 初期値設定
    _instance.router = await createRouter(updateRouter: updateRouter)
    return _instance;
  }

  void update() {
    
  }
}

// ルーターの作成
Future<GoRouter> createRouter({required VoidCallback updateRouter}) async {
  // jwtkeyが端末内に保存されているかを判別
  Future<bool> isLoginCheck() async {
    User user = await User.getUser();
    if (user.jwtKey == "") {
      return false;
    }
    return true;
  }

  bool isLogin = await isLoginCheck();
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: isLogin ? '/home' : '/login', // ログイン状態によって初期画面を変更
    // initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageLogin(
            updRouter: updateRouter,
          ),
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageUserRegister(
            updRouter: updateRouter,
          ),
        ),
      ),
      // ボトムバーが必要な画面のルーティング
      // いらなければ StatefulShellRoute と同じ階層に GoRoute で書く
      StatefulShellRoute.indexedStack(
          // parentNavigatorKey: rootNavigatorKey,    // これがあると初期画面で/homeにたどり着けない 原因究明中
          // ここで常時表示させたいクラスをビルドしている
          builder: (context, state, navigationShell) {
            return BasicScreenView(navigationShell: navigationShell);
          },
          branches: [...await getBranches()])
    ],
  );
}
