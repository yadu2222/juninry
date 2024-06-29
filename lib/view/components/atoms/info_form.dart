import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

class InfoForm extends StatelessWidget {
  const InfoForm({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.main,    // カーソルの色
        decoration: InputDecoration(
          labelText: label,
          fillColor: AppColors.iconLight, // 背景色
          filled: true, // 背景色を表示
          border: const OutlineInputBorder(
              borderSide: BorderSide.none, // ボーダーを非表示にする
              borderRadius: BorderRadius.all(Radius.circular(50)) // 角を丸くする
              ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0), // テキストの内側の余白
        ),
      ),
    );
  }
}
