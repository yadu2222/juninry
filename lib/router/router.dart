import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 遷移先
// junior
import '../view/components/organism/basic_view.dart';
import '../view/pages/junior/page_home.dart';
import '../view/pages/junior/page_homework.dart';
import '../view/pages/junior/page_notice.dart';
import '../view/pages/junior/page_user.dart';
import 'package:juninry/view/pages/junior/page_nextday_task.dart';
import '../view/pages/junior/page_students.dart';
import '../view/pages/junior/page_submission.dart';

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
                routes: [
                  GoRoute(
                    name: 'students',
                    path: 'students',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const PageStudentsJunior(),
                    ),
                  ),
                ],
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: PageHomeJunior(),
                ),
              ),
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
              GoRoute(
                name: 'homework',
                path: '/homework',
                routes: [
                  GoRoute(
                    name: 'nextdayTask',
                    path: 'nextday',
                    pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child:  PageNextDayTaskJunior()),
                  ),
                  GoRoute(name: 'submittion', path: 'submittion', pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child:  PageSubmissionJunior()))
                ],
                pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child:  PageHomeworkJunior()),

              ),
              
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
