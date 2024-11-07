import 'package:flutter/material.dart';
import '../../components/atoms/appbar.dart';

// appbar + Column
class BasicTemplate extends StatelessWidget {
  final String title;
  final bool popIcon;
  final List<Widget> children;
  final IconButton? featureIconButton;
  final bool Function()? popFunction;

  const BasicTemplate(
      {super.key,
      required this.title,
      this.popIcon = false,
      required this.children,
      this.featureIconButton,
      this.popFunction});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      AppBarView(
        titleText: title,
        popIconButton: popIcon,
        featureIconButton: featureIconButton,
        popFunction: popFunction,
      ), // appbar
      ...children,
    ]));
  }
}
