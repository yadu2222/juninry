import 'package:flutter/material.dart';
import '../../components/atoms/appbar.dart';

// appbar + Column
class BasicTemplate extends StatelessWidget {
  final String title;
  final bool popIcon;
  final List<Widget> children;
  final IconButton? featureIconButton;

  BasicTemplate({
    required this.title,
    this.popIcon = false,
    required this.children,
    this.featureIconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(
        titleText: title,
        popIconButton: popIcon,
        featureIconButton: featureIconButton,
      ), // appbar
      ...children,
    ]));
  }
}
