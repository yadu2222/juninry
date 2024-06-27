import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

// bottombar
// 基本触らない
class BottomBarView extends StatelessWidget implements PreferredSizeWidget {
  const BottomBarView({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  // TODO:ここもユーザーのタイプに合わせて表示すべきですよね、、という話
  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.iconLight,
            width: 1.5,
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: 5),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'おしらせ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '宿題',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'マイページ',
          ),
        ],
        currentIndex: selectedIndex,
        backgroundColor: AppColors.main,
        selectedItemColor: AppColors.iconLight,
        // unselectedItemColor: AppColors.fontLight,
        onTap: onItemTapped, // タップ時の処理
        type: BottomNavigationBarType.fixed,
      ));

  // 高さの設定
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
