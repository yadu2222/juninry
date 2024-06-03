import 'package:flutter/material.dart';

class ListItemBox extends StatelessWidget {
  const ListItemBox({
    super.key,
    this.height,
    required this.itemDatas,
    required this.listItem,
  });

  final double? height; // 高さ
  final List itemDatas; // リストデータ
  final Widget Function(Map map) listItem; // ウィジェット関数

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        height: height != null ? MediaQuery.of(context).size.height * height! : null,
        child: ListView.builder(
          itemCount: itemDatas.length,
          itemBuilder: (BuildContext context, int index) {
            return listItem(itemDatas[index]);
          },
        ));
  }
}
