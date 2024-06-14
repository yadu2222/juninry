import 'package:flutter/material.dart';
import '../../components/atoms/appbar.dart';

// appbar + ListView (無限スクロールだねということ)
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
       child:
       
       Column(children: [
      AppBarView(
        titleText: title,
        popIconButton: popIcon,
        featureIconButton: featureIconButton,
      ), // appbar
     Expanded(
          child: SingleChildScrollView(
            child: Column(
            
          children: [
        ...children
      ]))
    )]));
  }

  
}
