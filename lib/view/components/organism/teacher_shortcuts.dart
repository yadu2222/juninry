import 'package:flutter/material.dart';
import '../../components/molecule/shortcut_set.dart';

// こんなふうに各ユーザータイプにあわせたショートカットのセットをつくる
class TeacherShortcuts extends StatelessWidget {
  // ショートカットボタンのタイトル
  final List<String> shortcutList = [
    '宿題登録',
    'お知らせ登録',
    '生徒一覧',
    '教材管理',
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
