import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
// import '../../../router/router.dart';

// bottombar
// 基本触らない
class BottomBarView extends StatelessWidget implements PreferredSizeWidget {
  const BottomBarView({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isOuchi
  });
  const BottomBarView.teacher({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isOuchi
  });

  final bool isOuchi;

  List<BottomNavigationBarItem> getItems()  {
    BottomNavigationBarItem home = const BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'ホーム',
    );

    BottomNavigationBarItem notice = const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_none_outlined),
      label: 'おしらせ',
    );
    BottomNavigationBarItem homework = const BottomNavigationBarItem(
      icon: Icon(Icons.book_outlined),
      label: '宿題',
    );
    BottomNavigationBarItem ouchi = const BottomNavigationBarItem(
      icon: Icon(Icons.door_front_door),
      label: 'おうち',
    );
    BottomNavigationBarItem mypage = const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'マイページ',
    );

    final List<BottomNavigationBarItem> items = [];

    items.add(home);
    items.add(notice);
    items.add(homework);
    if (isOuchi) {
      items.add(ouchi);
    }
    items.add(mypage);

    return items;
  }

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          items:getItems(),
          currentIndex: selectedIndex,
          backgroundColor: AppColors.main,
          selectedItemColor: AppColors.iconLight,
          // unselectedItemColor: AppColors.fontLight,
          onTap: onItemTapped, // タップ時の処理
          type: BottomNavigationBarType.fixed,
        ));
  }

  // 高さの設定
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
