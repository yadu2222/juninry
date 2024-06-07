import 'package:flutter/material.dart';


// これを使ってリストをつくってね
class ListItemBox<Model> extends StatelessWidget {
  const ListItemBox({
    super.key,
    this.height,
    required this.itemDatas,
    required this.listItem,
  });

  final double? height; // 高さ
  final List<Model> itemDatas; // リストデータ
  final Widget Function(Model item) listItem; // カード ウィジェット関数

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
