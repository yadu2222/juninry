import 'package:flutter/material.dart';
import '../../../models/homework_model.dart';
import '../molecule/submittion_card.dart';
import '../../../constant/fonts.dart';
import 'dart:io'; // ファイル操作用ライブラリ

// 提出リスト
class SubmittionList extends StatelessWidget {
  const SubmittionList({super.key, required this.homeworkData, required this.images, this.pickImage});
  final Homework homeworkData;
  final List<File?> images;
  final void Function(int index)? pickImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: SingleChildScrollView(
            child: Column(
                children: images.asMap().entries.map((entry) {
          final index = entry.key; // インデックス
          final item = entry.value; // アイテム
          return item == null
              ? InkWell(
                  onTap: () {
                    // カメラ起動
                    if (pickImage != null) {
                      pickImage!(index);
                    }
                  },
                  child:
                      // TODO:撮り直しはできたほうがいいけど提出済の画像に対してカメラが起動してしまうため対処を要検討中
                      // item != null
                      //     ? Container(
                      //         margin: const EdgeInsets.all(5),
                      //         child: Column(children: [
                      //           Image.file(
                      //             item,
                      //             width: MediaQuery.of(context).size.width * 0.9, // 画像の幅を指定
                      //             height: 200, // 高さを指定
                      //             fit: BoxFit.contain, // サイズに合わせて画像を調整
                      //           ),
                      //           Text('${(homeworkData.startPage + index).toString()}p', style: Fonts.h4)
                      //         ]))
                      //     :
                      SubmittionCard(count: homeworkData.startPage + index))
              : Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(children: [
                    Image.file(
                      item,
                      width: MediaQuery.of(context).size.width * 0.9, // 画像の幅を指定
                      height: 200, // 高さを指定
                      fit: BoxFit.contain, // サイズに合わせて画像を調整
                    ),
                    Text('${(homeworkData.startPage + index).toString()}p', style: Fonts.h4)
                  ]));
        }).toList())));
  }
}
