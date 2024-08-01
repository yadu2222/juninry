import 'package:flutter/material.dart';

// これを使ってリストカードをつくってね
class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.all(5),
    this.height,
    required this.widget,
    this.spreadRadius,
  });

  final EdgeInsetsGeometry padding; // デフォルト値を用意しているので渡さなくても良い
  final EdgeInsetsGeometry margin; // 同上
  final double? height; // 値を入れなければ中身に合わせて調整される
  final Widget widget; // 中身
  final double? spreadRadius; // 影のサイズ

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            // spreadRadius: 1.0,
            blurRadius: 1,
            offset: const Offset(0, 1),
            spreadRadius: spreadRadius ?? 0.0,
          ),
        ],
      ),
      height: height,
      width: MediaQuery.of(context).size.width * 0.92,
      child: widget,
    );
  }
}
