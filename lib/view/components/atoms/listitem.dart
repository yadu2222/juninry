import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.all(5),
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
      padding: padding,
      margin: margin,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            // spreadRadius: 1.0,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      height: height,
      width: MediaQuery.of(context).size.width * 0.92,
      child: widget,
    );
  }
}
