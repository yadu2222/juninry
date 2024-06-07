import 'package:flutter/material.dart';
import '../../components/molecule/shortcut_set.dart';


// こんなふうに各ユーザータイプにあわせたショートカットのセットをつくる
class JuniorShortcuts extends StatelessWidget {
 

  // ショートカットボタンのタイトル
  final List<String> shortcutList = [
    'ホーム',
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
