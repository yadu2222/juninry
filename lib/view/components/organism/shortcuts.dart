import 'package:flutter/material.dart';
import '../../components/molecule/shortcut_set.dart';

// 保護者用ショートカット
class Shortcuts extends StatelessWidget {
  final int userType;
  Shortcuts.teacher({super.key, this.userType = 1});
  Shortcuts.junior({super.key, this.userType = 2});
  Shortcuts.patron({super.key, this.userType = 3});

  final List shortcutList = [

    // 0 : teacher
    {
      'title': [
        '教員一覧',
        'おしらせ',
        '生徒一覧',
        '課題一覧',
      ],
      'pass': [
        '/home',
        '/notice',
        '/home/students',
        '/homework',
      ],
      'icons': [
        Icons.home_outlined,
        Icons.notifications_none,
        Icons.face_outlined,
        Icons.menu_book_rounded,
      ]
    },
    // 1:junior
    {
      'title': [
        '宿題登録',
        'お知らせ登録',
        '生徒一覧',
        '教材管理',
      ],
      'pass': [
       '/homework/register',
        '/notice',
        '/home/students',
        '/homework',
      ],
      'icons': [
        Icons.menu_book_rounded,
        Icons.notifications_none,
        Icons.face_outlined,
        Icons.book_outlined,
      ]
    },
     // 2 : patron
    {
      'title': [
        '教員一覧',
        'おしらせ',
        '生徒一覧',
        '課題一覧',
      ],
      'pass': [
        '/home',
        '/notice',
        '/home/students',
        '/homework',
      ],
      'icons': [
        Icons.home_outlined,
        Icons.notifications_none,
        Icons.face_outlined,
        Icons.menu_book_rounded,
      ]
    },

  ];

  @override
  Widget build(BuildContext context) {
    return ShortcutSet(shortcutList: shortcutList[userType - 1]['title'], icons: shortcutList[userType - 1]['icons'], movePages: shortcutList[userType - 1]['pass']);
  }
}
