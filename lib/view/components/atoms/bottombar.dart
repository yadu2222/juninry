import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

class BottomBarView extends StatelessWidget implements PreferredSizeWidget {
  const BottomBarView({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
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
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        currentIndex: selectedIndex,
        backgroundColor: AppColors.main,
        selectedItemColor: AppColors.iconLight,   // 選択中のアイコンの色
        // unselectedItemColor: AppColors.fontLight,
        onTap: onItemTapped, // タップ時の処理
        type: BottomNavigationBarType.fixed,
      );

  // 高さの設定
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
