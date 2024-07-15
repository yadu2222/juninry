import 'package:flutter/material.dart';

import '../../../models/homework_model.dart';
import '../molecule/submittion_card.dart';
import '../../../constant/fonts.dart';

// カメラを使用するためのライブラリ
// import 'package:camera/camera.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

// 提出リスト
class SubmittionList extends StatelessWidget {
//   final Homework homeworkData;
//   final void Function() onTakeCamera; // 撮影時の処理
//   const SubmittionList({super.key, required this.homeworkData, required this.onTakeCamera});

//   @override
//   SubmittionListState createState() => SubmittionListState();
// }

// class SubmittionListState extends State<SubmittionList> {
  const SubmittionList({super.key, required this.homeworkData,required this.pageCount,required this.images,required this.pickImage});

  final Homework homeworkData;
  final int? pageCount;
  final List<File?> images;
  final void Function(int index) pickImage;

  // TODO:SingleChildScrollView対応
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: ListView.builder(
          // カメラの処理と条件分岐が複雑なためここで定義
          itemCount: pageCount,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  // カメラ起動
                  pickImage(index);
                },
                child: images[index] != null
                    ? Container(margin: const EdgeInsets.all(5), child: Column(children: [Image.file(images[index]!), Text('${(pageCount! - (pageCount! - index - 1)).toString()}p', style: Fonts.h4)]))
                    : SubmittionCard(count: pageCount! - (pageCount! - index - 1)));
          },
        ));
  }
}
