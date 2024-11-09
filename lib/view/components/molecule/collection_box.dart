import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';

// 画像カード 通信の失敗などが起こっていればアイコン表示
class CollectionBox extends StatelessWidget {
  const CollectionBox({super.key, this.imagePath});

  final String? imagePath; // 画像用配列
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: AppColors.iconLight,
      ),
      child: imagePath == null
          ? Image.asset("assets/images/hatena.PNG", fit: BoxFit.contain)
          : Image.network(
              "http://localhost:4561/images/${imagePath!}",
              fit: BoxFit.contain, // サイズに合わせて画像を調整
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/hatena.PNG", fit: BoxFit.contain);
              },
            ),
    );
  }
}
