import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/router/router.dart';
import '../atoms/screenview.dart';
import '../atoms/bottombar.dart';

/**
 * ホーム画面以外の雛形
 */
class BasicScreenView extends HookWidget {
  const BasicScreenView({
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
    final isOuchi = useState<bool>(false); // おうちモードかどうか
    useEffect(() {
      // 初回起動時に選択
      Future<void> isOuchiCheck() async {
        isOuchi.value = await getBranches() != BranchType.teacher.branch;
      }
      isOuchiCheck();
      return () {};
    }, []);

    return ScreenView(
      widget: navigationShell, // routeから渡される
      bottomBar: BottomBarView(
        selectedIndex: navigationShell.currentIndex,
        onItemTapped: _onItemTapped,
        isOuchi: isOuchi.value,
      ),
    );
  }
}
