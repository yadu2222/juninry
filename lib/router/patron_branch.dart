import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 遷移先
// patron
import '../view/pages/patron/page_home.dart';
import '../view/pages/patron/page_notice_detail.dart';
// 暫定的ホームたちにjuniorを使用
import '../view/pages/junior/page_homework.dart';
import '../view/pages/junior/page_notice.dart';
import '../view/pages/junior/page_user.dart';

// 保護者ブランチ
class PatronBranch {
  static List<StatefulShellBranch> patronBranchs = [
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
      routes: [
        // home
        GoRoute(
          name: 'home',
          path: '/home',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const PageHomePatron(),
            // child: PageHomePatron(),
          ),
        ),
      ],
    ),

    // notice
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'notice'),
      routes: [
        // おしらせ一覧
        GoRoute(
          name: 'notice',
          path: '/notice', // notice
          routes: [
            // お知らせ詳細
            // TODO:引数
            GoRoute(
              path: 'detail',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageNoticeDetailPatron(
                  noticeUUID: '123456',
                ),
              ),
            )
          ],

          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const PageNoticeJunior(),
          ),
        ),
      ],
    ),

    // homework
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'homework'),
      routes: [
        GoRoute(
          name: 'homework',
          path: '/homework',
       
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageHomeworkJunior()),
        ),
      ],
    ),

    // userData
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'userData'),
      routes: [
        GoRoute(
          name: 'userData',
          path: '/userData',
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageUserDataJunior()),
        )
      ],
    ),
  ];
}
