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
import '../view/pages/teacher/page_notice_detail.dart';
import '../view/pages/junior/page_submission.dart';

// patron
import '../view/pages/patron/page_home.dart';

// teacher
import '../view/pages/teacher/page_create_notice.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final noticeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'notice');
final homeworkNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homework');
final userDataNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'userData');

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/create',
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
                  // child: PageHomeJunior(),
                  child: PageHomePatron(),
                ),
              ),
            ],
          ),

          // notice
          StatefulShellBranch(
            navigatorKey: noticeNavigatorKey,
            routes: [
              // GoRoute(
              //   name: 'notice',
              //   path: '/notice', // notice
              //   pageBuilder: (context, state) => NoTransitionPage(
              //     key: state.pageKey,
              //     child: const PageNoticeJunior(),
              //   ),
              // ),
              GoRoute(
                path: '/detail',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: PageNoticeDetail(),
                ),
              ),

              GoRoute(
                path: '/create',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: PageCreateNotice(),
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
                    pageBuilder: (context, state) => NoTransitionPage(
                        key: state.pageKey, child: PageNextDayTaskJunior()),
                  ),
                  GoRoute(
                    name: 'submittion',
                    path: 'submittion',
                    pageBuilder: (context, state) {
                      // 遷移時のデータの受け渡し
                      // extraがnullである場合trycatchでエラーを回避
                      if (state.extra != null) {
                        // 遷移時に定義されたデータをrouterで再定義
                        final Map<String, dynamic> extraData =
                            state.extra as Map<String, dynamic>;
                        final String homeworkId = extraData['homeworkId'];
                        return NoTransitionPage(
                          key: state.pageKey,
                          // 先ほど再定義したデータをここで渡す
                          child: PageSubmissionJunior(homeworkUUId: homeworkId),
                        );

                        // TODO:errorpage ホームに戻すのでいいかな？
                      } else {
                        return NoTransitionPage(
                          key: state.pageKey,
                          child: const PageHomeworkJunior(),
                        );
                      }
                    },
                  )
                ],
                pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey, child: PageHomeworkJunior()),
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
                pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey, child: const PageUserDataJunior()),
              )
            ],
          ),
        ])
  ],
);
