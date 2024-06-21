import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/notice_register_model.dart';
import 'package:juninry/view/pages/teacher/page_notice_draft.dart';

// 遷移先
// teacher
import '../view/pages/teacher/page_home.dart';
import '../view/pages/teacher/page_notice_detail.dart';
import '../view/pages/teacher/page_notice_register_teacher.dart';
import '../view/pages/teacher/page_homework.dart';
import '../view/pages/teacher/page_homework_register.dart';
import '../view/pages/share/page_students.dart';

// 暫定的ホームたちにjuniorを使用
import '../view/pages/junior/page_notice.dart';
import '../view/pages/junior/page_user.dart';

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
          ],
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const PageHomeTeacher(),
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
              path: 'register',
              pageBuilder: (context, state) {
                if (state.extra != null) {
                  // Map型でデータを送るためそれを取得
                  final Map<String, dynamic> extraData =
                      state.extra as Map<String, dynamic>;
                  // 取り出す
                  final DraftedNotice draftedNoticeData =
                      extraData['draftedNoticeData'];
                  print(inspect(draftedNoticeData));
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageNoticeRegisterTeacher(
                      draftedNoticeData: draftedNoticeData,
                    ),
                  );
                } else {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageNoticeRegisterTeacher(),
                  );
                }
              },
            ),
            GoRoute(
              path: "draft",
              pageBuilder: (context, state) {
                if (state.extra != null) {
                  // Map型でデータを送るためそれを取得
                  final Map<String, dynamic> extraData =
                      state.extra as Map<String, dynamic>;
                  // 取り出す
                  final DraftedNotice draftedNoticeData =
                      extraData['draftedNoticeData'];
                  print(inspect(draftedNoticeData));
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageNoticeDraftTeacher(
                      draftedNoticeData: draftedNoticeData,
                    ),
                  );
                } else {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageNoticeDraftTeacher(),
                  );
                }
              },
            ),
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

          routes: [
            GoRoute(
              name: 'register',
              path: 'register',
              pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const PageHomeworkRegisterTeacher()),
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
          pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey, child: const PageUserDataJunior()),
        )
      ],
    ),
  ];
}
