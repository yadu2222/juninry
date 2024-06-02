import 'package:flutter/material.dart';
import 'bottombar.dart';
import '../../../constant/colors.dart';

/**
 * 常時表示部分
 */
class ScreenView extends StatelessWidget {
  const ScreenView({
    super.key,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
    // required this.appBar,
    required this.widget,
    required this.bottomBar,
  });

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  // final AppBarView appBar;
  final Widget widget;
  final BottomBarView bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main, // 背景色設定
      // appBar:appBar,
      body: widget,
      bottomNavigationBar: bottomBar,
    );
  }
}
