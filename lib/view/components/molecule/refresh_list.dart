import 'package:flutter/material.dart';

class RefreshList extends StatelessWidget {
  const RefreshList({super.key, this.height, required this.itemDatas, required this.list, required this.text, required this.refresh});

  final String text;
  final double? height; // 高さ
  final List itemDatas; // リストデータ
  final Widget list; // カード ウィジェット関数
  final Future<void> Function() refresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: itemDatas.isEmpty
            ? ListView(
                // 空のリストビューでもスクロールできるようにする
                children: [
                  Center(child: Text('まだ$textがありません')),
                ],
              )
            : list);
  }
}
