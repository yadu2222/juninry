import 'package:flutter/material.dart';

// 保有ポイントの表示
class StampBox extends StatelessWidget {
  final bool isStamp;
  const StampBox({super.key, required this.isStamp});

  @override
  Widget build(BuildContext context) {
    return Container(width: 77, height: 77, margin: const EdgeInsets.all(5), child: isStamp ? Image.asset("assets/images/stamp.png", fit: BoxFit.contain) : const SizedBox.shrink());
  }
}
