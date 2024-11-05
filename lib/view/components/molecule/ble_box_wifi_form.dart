import 'package:flutter/material.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/atoms/info_form.dart';

class BoxWifiForm extends StatelessWidget {
  final TextEditingController ssidController;
  final TextEditingController passwordController;
  final Function() onSave;
  final Function() onCancel;

  const BoxWifiForm({
    super.key,
    required this.ssidController,
    required this.passwordController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Wi-Fi設定',
              style: Fonts.h3,
            )),
        InfoForm(
          label: 'SSID',
          controller: ssidController,
          isBorder: true,
        ),
        InfoForm(
          label: 'Password',
          controller: passwordController,
          isBorder: true,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BasicButton(
                isColor: false, width: 0.3, text: '削除', onPressed: onCancel),
            BasicButton(
                isColor: true, width: 0.3, text: '保存', onPressed: onSave),
          ],
        ),
      ],
    );
  }
}
