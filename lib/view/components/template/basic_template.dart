import 'package:flutter/material.dart';
import '../../components/atoms/appbar.dart';

// appbar + Column
class BasicTemplate extends StatelessWidget {
  final String title;
  final bool appIcon;
  final List<Widget> children;
  final IconButton? featureIconButton;

  BasicTemplate({
    required this.title,
    this.appIcon = false,
    required this.children,
    this.featureIconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(
        titleText: title,
        popIconButton: appIcon,
        featureIconButton: featureIconButton,
      ), // appbar
      ...children,
    ]));
  }
}
