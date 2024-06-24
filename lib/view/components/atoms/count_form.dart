import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../constant/fonts.dart';

class CountForm extends HookWidget {
  CountForm({
    super.key,
    required this.startController,
    required this.countController,
  });

  final TextEditingController startController;
  final TextEditingController countController;

  @override
  Widget build(BuildContext context) {
    // 入力タイプ切り替え
    final isType = useState<bool>(false);
    void _onPressed() {
      isType.value = !isType.value;
    }

    Widget editForm(TextEditingController controller) {
      return Expanded(
          child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3), // 高さ
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              )));
    }

    // 枚数入力
    List<Widget> widget1 = [
      editForm(startController),
      const Text(
        '枚',
        style: Fonts.h4,
      ),
    ];

    // ページ数入力
    List<Widget> widget2 = [
      editForm(startController),
      const Text(
        'P 〜',
        style: Fonts.h4,
      ),
      editForm(countController),
      const Text(
        'P',
        style: Fonts.h4,
      ),
    ];

    return Row(children: [IconButton(icon: const Icon(Icons.autorenew), onPressed: _onPressed), ...isType.value ? widget1 : widget2]);
  }
}
