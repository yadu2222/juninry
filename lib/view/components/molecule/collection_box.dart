import 'package:flutter/material.dart';

import 'dart:io';

// 画像カード 通信の失敗などが起こっていればアイコン表示
class CollectionBox extends StatelessWidget {
  const CollectionBox({super.key, this.image});

  final File? image; // 画像用配列
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(5),
      child: image == null
          ? Image.asset("assets/images/hatena.PNG", fit: BoxFit.contain)
          : Image.file(
              image!,
              fit: BoxFit.contain, // サイズに合わせて画像を調整
            ),
    );
  }
}
