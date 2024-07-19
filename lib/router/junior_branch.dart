import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './router.dart';

// junior遷移先
// home
import '../view/pages/share/page_home.dart';
import '../view/pages/share/page_students.dart';
import '../view/pages/share/page_class.dart';
// homework
import '../view/pages/junior/page_homework.dart';
import '../view/pages/junior/page_submission.dart';
import '../view/pages/junior/page_nextday_task.dart';
// notice
import '../view/pages/junior/page_notice.dart';
// ouchi
import '../view/pages/junior/page_ouchi.dart';
import '../view/pages/junior/page_reward.dart';
import '../view/pages/junior/page_join_ouchi.dart';
// user
import '../view/pages/share/page_user.dart';

// こどもブランチ
class JuniorBranch {
  static List<StatefulShellBranch> juniorBranchs = [
    // home
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          routes: [
            // 生徒一覧
            GoRoute(
              name: 'students',
              path: 'students',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageStudents(),
              ),
            ),
            // クラスに参加
            GoRoute(
              name: 'class',
              path: 'class',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: PageClass(),
              ),
            ),
          ],
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const PageHome.junior(),
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
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: PageNoticeJunior(),
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
            // 次の日の課題
            GoRoute(
              name: 'nextdayTask',
              path: 'nextday',
              pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: PageNextDayTaskJunior()),
            ),
            // 提出
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
                    child: PageSubmissionJunior(homeworkUUID: homeworkId),
                  );

                  // TODO:errorpage よういしたい
                } else {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const PageHomeworkJunior(),
                  );
                }
              },
            )
          ],
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageHomeworkJunior()),
        ),
      ],
    ),

    // ouchi
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'ouchi'),
      routes: [
        GoRoute(
          name: 'ouchi',
          path: '/ouchi',
          routes: [
            GoRoute(
              name: 'GOHOUBI',
              path: 'reward', // notice
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageRewardJunior(),
              ),
            ),
            GoRoute(
              name: 'join',
              path: 'join',
              pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child:  PageJoinOUCHI()),
            ),
          ],
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child:  PageJoinOUCHI()),
        )
      ],
    ),

    // userData
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'userData'),
      routes: [
        GoRoute(
          name: 'userData',
          path: '/userData',
          pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageUserData()),
        )
      ],
    ),
  ];
}
