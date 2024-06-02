import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../atoms/screenview.dart';
import '../atoms/bottombar.dart';

/**
 * ホーム画面以外の雛形
 */
class BasicScreenView extends StatelessWidget {
  BasicScreenView({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  // アイテムがタップされたらルート処理
  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      widget: navigationShell,    // routeから渡される
      bottomBar: BottomBarView(
        selectedIndex: navigationShell.currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
