import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 遷移先
// patron
// home
import '../view/pages/patron/page_home.dart';
import '../view/pages/share/page_students.dart';
// notice
import '../view/pages/share/page_notice.dart';
import '../view/pages/share/page_notice_detail.dart';
// homework
import '../view/pages/share/page_homework.dart';
import '../view/pages/patron/page_submittion.dart';
// ouchi
import '../view/pages/share/page_ouchi.dart';
import '../view/pages/patron/page_ouchi_top.dart';
// setting
import '../view/pages/share/page_questions.dart';
import '../view/pages/share/page_user.dart';

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
          ],
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
              pageBuilder: (context, state) {
                debugPrint("state.extra: ${state.extra}");
                // Map型でデータを送るためそれを取得
                final Map<String, dynamic> extraData =
                    state.extra as Map<String, dynamic>;
                // データを取り出してみる
                final String? noticeUUID = extraData['noticeUUID'];
                return NoTransitionPage(
                  key: state.pageKey,
                  child: PageNoticeDetail(
                    noticeUuid: noticeUUID!,
                  ),
                );
              },
            ),
          ],

          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: PageNotice(),
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
              name: 'nextday',
              path: 'nextday',
              pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const PageHomework.near(
                      // userUUID: '',
                      )), // TODO:遷移処理
            ),
            // 課題提出
            GoRoute(
                name: 'submittion',
                path: 'submittion',
                pageBuilder: (context, state) {
                  if (state.extra != null) {
                    // 遷移時に定義されたデータをrouterで再定義
                    final Map<String, dynamic> extraData =
                        state.extra as Map<String, dynamic>;
                    final String homeworkId = extraData['homeworkId'];
                    return NoTransitionPage(
                      key: state.pageKey,
                      // 先ほど再定義したデータをここで渡す
                      child: PageSubmissionPatron(homeworkUUId: homeworkId),
                    );

                    // TODO:errorpage よういしたい
                  } else {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: const PageHomework.near(),
                    );
                  }
                })
          ],
          pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey, child: const PageHomework.near()),
        ),
      ],
    ),
    // ouchi
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'ouchi'),
      routes: [
        GoRoute(
          name: 'outhi',
          path: '/ouchi',
          routes: [
            GoRoute(
              path: 'top',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageOuchiTopPatron(),
              ),
            )
          ],
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const PageOuchi()),
        )
      ],
    ),

    // settings
    StatefulShellBranch(
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'setting'),
      routes: [
        GoRoute(
          name: 'settings',
          path: '/settings',
          routes: [
            GoRoute(
              name: 'questions',
              path: 'questions', // notice
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageQuestions(),
              ),
            ),
          ],
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const PageUserData()),
        )
      ],
    ),
  ];
}
