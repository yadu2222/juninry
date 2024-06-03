import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/view/pages/junior/page_nextday_task.dart';

// 遷移先
import '../view/components/organism/basic_view.dart';
import '../view/pages/junior/page_home.dart';
import '../view/pages/junior/page_homework.dart';
import '../view/pages/junior/page_notice.dart';
import '../view/pages/junior/page_user.dart';
import '../view/pages/junior/page_sample.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final noticeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'notice');
final homeworkNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homework');
final userDataNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'userData');



final router = GoRouter(
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
        branches: [
          // home
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                name: 'home',
                path: '/home',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child:  PageHomeJunior(),
                ),
              ),
               GoRoute(
                name: 'sample',
                path: '/sample',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const PageSample(),
                ),
              )
            ],
          ),

          // notice
          StatefulShellBranch(
            navigatorKey: noticeNavigatorKey,
            routes: [
              GoRoute(
                name: 'notice',
                path: '/notice',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const PageNoticeJunior(),
                ),
              )
            ],
          ),

          // homework
          StatefulShellBranch(
            navigatorKey: homeworkNavigatorKey,
            routes: [
              // GoRoute(
              //   name: 'homework',
              //   path: '/homework',
              //   pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageHomeworkJunior()),
              // ),
              GoRoute(
                // name: 'nextdayTask',
                // path: '/nextday',
                name: 'homework',
                path: '/homework',
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageNextDayTaskJunior()),
              )
            ],
          ),

          // userData
          StatefulShellBranch(
            navigatorKey: userDataNavigatorKey,
            routes: [
              GoRoute(
                name: 'userData',
                path: '/userData',
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageUserDataJunior()),
              )
            ],
          ),
        ])
  ],
);