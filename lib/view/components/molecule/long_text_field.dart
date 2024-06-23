import 'package:flutter/material.dart';

import '../../../constant/fonts.dart';

// 長文テキスト入力
class LongTextField extends StatelessWidget {
  final TextEditingController textController;
  const LongTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.top,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "内容を入力してください",
      ),
      style: Fonts.p,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: textController,
    );
  }
}
