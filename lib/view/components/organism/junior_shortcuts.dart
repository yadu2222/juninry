import 'package:flutter/material.dart';
import '../../components/molecule/shortcut_set.dart';

class JuniorShortcuts extends StatelessWidget {
  JuniorShortcuts({Key? key}) : super(key: key);

  // ショートカットボタンのタイトル
  final List<String> shortcutList = [
    'ホーム',
    'おしらせ',
    'ユーザー',
    '課題一覧',
  ];

  // 遷移先のパス
  final List<String> movePages = [
    '/home',
    '/notice',
    '/userData',
    '/homework',
  ];

  // ショートカットボタンのアイコン
  final List<IconData> icons = [
    Icons.home,
    Icons.notifications,
    Icons.person,
    Icons.menu_book_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return ShortcutSet(shortcutList: shortcutList, icons: icons, movePages: movePages);
  }
}
