import 'package:flutter/material.dart';
import '../../components/atoms/appbar.dart';

// appbar + SingleChildScrollView (無限スクロールだねということ)
// 特定の部分のみをスクロールさせたいのではなく、画面全体をスクロールさせたい場合に使用
class ScrollTemplate extends StatelessWidget {
  final String title;
  final bool popIcon;
  final List<Widget> children;
  final IconButton? featureIconButton;

  const ScrollTemplate({
    super.key,
    required this.title,
    this.popIcon = false,
    required this.children,
    this.featureIconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      // appbar
      AppBarView(
        titleText: title,
        popIconButton: popIcon,
        featureIconButton: featureIconButton,
      ),
      // widget表示部分
      // SingleChildScrollViewを使用することで、中身がページサイズを超える場合のみスクロール可能になる
      Expanded(child: SingleChildScrollView(child: Column(children: [...children])))
    ]));
  }
}
