import 'package:flutter/material.dart';
import '../../components/molecule/shortcut_set.dart';

// ショートカット
class Shortcuts extends StatelessWidget {
  final int userType;
  Shortcuts.teacher({super.key, this.userType = 0});
  Shortcuts.junior({super.key, this.userType = 1});
  Shortcuts.patron({super.key, this.userType = 2});

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
        '宿題一覧',
        'マイページ',
        '生徒一覧',
        '????',
      ],
      'pass': [
        '/homework/register',
        '/ouchi',
        '/home/students',
        '/home',
      ],
      'icons': [
        Icons.menu_book_rounded,
        Icons.person,
        Icons.face_outlined,
        Icons.auto_awesome,
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
    return ShortcutSet(shortcutList: shortcutList[userType]['title'], icons: shortcutList[userType]['icons'], movePages: shortcutList[userType]['pass']);
  }
}
