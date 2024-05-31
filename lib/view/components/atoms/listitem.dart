import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListItemBox extends StatelessWidget {
  const ListItemBox({
    super.key,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
    required this.height,
    required this.widget,
  });

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: height,
      width: double.infinity * 0.8,
      child: widget,
    );
  }
}
