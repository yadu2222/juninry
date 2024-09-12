import 'package:flutter/material.dart';

import '../atoms/listItem_box.dart';
import '../molecule/picture_card.dart';
import 'dart:io';

// 画像のリスト
// めっちゃしっかりエラーでそう〜〜；〜〜；
class PictureList extends StatelessWidget {
  const PictureList({super.key, required this.images});
  final List<File> images; // 画像用配列
  @override
  Widget build(BuildContext context) {
    return ListItemBox<File>(
      itemDatas: images,
      listItem: (file) => PictureCard(image: file),
    );
  }
}
