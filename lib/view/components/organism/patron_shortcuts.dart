import 'package:flutter/material.dart';
import '../../components/molecule/shortcut_set.dart';

// 保護者用ショートカット
class PatronShortcuts extends StatelessWidget {

  PatronShortcuts({super.key});


  // TODO:かえよう
  // ショートカットボタンのタイトル
  final List<String> shortcutList = [
    '教員一覧',
    'おしらせ',
    '生徒一覧',
    '課題一覧',
  ];

  // 遷移先のパス
  final List<String> movePages = [
    '/home',
    '/notice',
    '/home/students',
    '/homework',
  ];

  // ショートカットボタンのアイコン
  final List<IconData> icons = [
    Icons.home_outlined,
    Icons.notifications_none,
    Icons.face_outlined,
    Icons.menu_book_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return ShortcutSet(shortcutList: shortcutList, icons: icons, movePages: movePages);
  }
}
