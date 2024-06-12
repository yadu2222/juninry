import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 遷移先
// junior

import '../view/pages/junior/page_home.dart';
import '../view/pages/junior/page_homework.dart';
import '../view/pages/junior/page_notice.dart';
import '../view/pages/junior/page_user.dart';
import '../view/pages/junior/page_nextday_task.dart';
import '../view/pages/junior/page_students.dart';
import '../view/pages/junior/page_submission.dart';

class JuniorBranch {

  static List<StatefulShellBranch> juniorBranch = [
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
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
            child: const PageHomeJunior(),
            // child: PageHomePatron(),
          ),
        ),
      ],
    ),

    // notice
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'notice'),
      routes: [
        GoRoute(
          name: 'notice',
          path: '/notice', // notice

          // routes: [
          //   // TODO:先生のお知らせ詳細画面
          //   // GoRoute(
          //   //   path: 'detail',
          //   //   pageBuilder: (context, state) => NoTransitionPage(
          //   //     key: state.pageKey,
          //   //     child: const PageNoticeDetailTeacher(),
          //   //   ),
          //   // ),
          //   // TODO:保護者のお知らせ詳細画面
          //   GoRoute(
          //     path: 'detail',
          //     pageBuilder: (context, state) => NoTransitionPage(
          //       key: state.pageKey,
          //       child: const PageNoticeDetailPatron(
          //         noticeUUID: '123456',
          //       ),
          //     ),
          //   )
          // ],

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
          routes: [
            GoRoute(
              name: 'nextdayTask',
              path: 'nextday',
              pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: PageNextDayTaskJunior()),
            ),
            GoRoute(
              name: 'submittion',
              path: 'submittion',
              pageBuilder: (context, state) {
                // 遷移時のデータの受け渡し
                // extraがnullである場合trycatchでエラーを回避
                if (state.extra != null) {
                  // 遷移時に定義されたデータをrouterで再定義
                  final Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
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
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: PageHomeworkJunior()),
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
