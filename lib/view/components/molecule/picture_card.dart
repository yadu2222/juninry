import 'package:flutter/material.dart';

import '../atoms/listItem.dart';
import 'dart:io';

// 画像カード 通信の失敗などが起こっていればアイコン表示
class PictureCard extends StatelessWidget {
  const PictureCard({super.key, this.image});

  final File? image; // 画像用配列
  @override
  Widget build(BuildContext context) {
    return ListItem(
      widget: image == null ? const Column(
        children: [
          Icon(Icons.add_a_photo),
          Text('no image'),
        ],
      ) : Image.file(image!),
    );
  }
}
