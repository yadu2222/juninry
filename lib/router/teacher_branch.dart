import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/view/pages/share/page_notice.dart';
import 'package:juninry/view/pages/teacher/page_notice_draft.dart';

// 遷移先
// teacher
// home
import '../view/pages/share/page_home.dart';
import '../view/pages/share/page_students.dart';
import '../view/pages/share/page_class.dart';
// notice
import '../view/pages/teacher/page_notice_detail.dart';
import '../view/pages/teacher/page_notice_register.dart';
import '../view/pages/teacher/page_notice_quote.dart';

import '../view/pages/teacher/page_homework.dart';
import '../view/pages/teacher/page_homework_register.dart';
import '../view/pages/teacher/page_homework_drafts.dart';

// 暫定的ホームたちにjuniorを使用
// homework
// user
import '../view/pages/share/page_user.dart';

// 教員ブランチ
class TeacherBranch {
  static List<StatefulShellBranch> teacherBranchs = [
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
            // クラス作成
          ],
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            // child: const PageHomeTeacher(),
            child: const PageHome.teacher(),
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
            // TODO:引数
            GoRoute(
              path: 'detail',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageNoticeDetailTeacher(
                    // noticeUUID: '123456',
                    ),
              ),
            ),
            GoRoute(
              path: 'register', // お知らせ登録 お知らせの下書き、引用の管理はnotice_register_modelクラスを使う
              pageBuilder: (context, state) {
                // データが送られてきたとき
                if (state.extra != null) {
                  debugPrint("テストテストテスト");
                  debugPrint("extra: ${state.extra.toString()}");
                  // Map型でデータを送るためそれを取得
                  final Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
                  // データを取り出してみる
                  final int? draftedNoticeId = extraData['draftedNoticeId'];
                  final String? quotedNoticeUUID =
                      extraData['quotedNoticeUUID'];
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageNoticeRegisterTeacher(
                      draftedNoticeId: draftedNoticeId,
                      quotedNoticeUUID: quotedNoticeUUID,
                    ),
                  );
                } else {
                  debugPrint("何もきてない");

                  // データが送られてきなかったとき
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const PageNoticeRegisterTeacher(),
                  );
                }
              },
            ),
            GoRoute(
              path: "draft",
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PageNoticeDraftTeacher(),
              ),
            ),
            GoRoute(
              path: "quote",
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: PageNoticeQuoteTeacher(),
              ),
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
              name: 'register',
              path: 'register',
              routes: [
                GoRoute(
                  name: 'drafts',
                  path: 'drafts',
                  pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const PageHomeworkDraftsTeacher()),
                )
              ],
              pageBuilder: (context, state) {
                // 遷移時のデータの受け渡し
                // extraがnullである場合trycatchでエラーを回避
                // 下書きを選択している場合
                if (state.extra != null) {
                  // debugPrint("きちゃ");

                  // 遷移時に定義されたデータをrouterで再定義
                  final Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
                  final String selectDate = extraData['selectDate'];
                  print(selectDate);
                  return NoTransitionPage(
                    key: state.pageKey,
                    // 先ほど再定義したデータをここで渡す
                    child: PageHomeworkRegisterTeacher(selectDate: selectDate),
                  );

                  // 下書きを選択していない場合
                } else {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const PageHomeworkRegisterTeacher(),
                  );
                }
              },
            ),
          ],

          pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PageHomeworkTeacher(
                classUUID: '',
              )), // TODO:遷移処理？
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
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: const PageUserData()),
        )
      ],
    ),
  ];
}
