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
        child: MediaQuery.removePadding(
            // これでラップすると余白が削除される
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              itemCount: itemDatas.length,
              itemBuilder: (BuildContext context, int index) {
                return listItem(itemDatas[index]);
              },
            )));

    // // 空白に対応
    //   child: SingleChildScrollView(
    //       child: Column(
    //           children: itemDatas.asMap().entries.map((entry) {
    //     final index = entry.key; // インデックス
    //     final item = entry.value; // アイテム
    //     return InkWell(
    //         onTap: () {
    //           // nullチェック
    //           if (onTap != null) {
    //             onTap!(index);
    //           }
    //         },
    //         child: listItem(item));
    //   }).toList())),
    // );
  }
}
