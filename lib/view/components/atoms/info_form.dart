import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constant/colors.dart';

class InfoForm extends StatelessWidget {
  const InfoForm({
    super.key,
    required this.label,
    required this.controller,
    this.isIcon = false,
    this.onTap,
    this.icon = Icons.send,
    this.inputType = TextInputType.text,
    this.inputFormatter = const [],
  });

  final String label;
  final IconData icon;
  final bool isIcon;
  final void Function()? onTap;
  final TextEditingController controller;
  final TextInputType inputType; // 数値以外許さないか
  final List<dynamic> inputFormatter; // TextInputFormatter ひとまずの処置

  // TODO:バリデーション
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      child: TextFormField(
        keyboardType: inputType,
        inputFormatters: [...inputFormatter],
        controller: controller,
        cursorColor: AppColors.main, // カーソルの色
        decoration: InputDecoration(
          labelText: label,
          fillColor: AppColors.iconLight, // 背景色
          filled: true, // 背景色を表示
          // 右側のアイコン
          suffixIcon: isIcon
              ? SizedBox(
                  width: 50, // IconButton の幅を固定
                  child: IconButton(
                    icon: Icon(icon),
                    onPressed: () async {
                      FocusScope.of(context).unfocus(); // キーボードを閉じる
                      onTap!();
                    },
                  ),
                )
              : const SizedBox.shrink(),
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
