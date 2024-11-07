import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
// view
import '../../components/template/basic_template.dart';

class PageGatya extends HookWidget {
  PageGatya({super.key});

  final String title = 'ガチャ';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      // ガチャのバナー
      // Text("いろんな姿のニャリオットやアイテムをゲットしよう！"),
      SizedBox(
          width: 500,
          height: 500,
          child: Image.asset(
            'assets/images/gatya.png',
            width: 200,
            fit: BoxFit.contain,
          )),

      Row(
        children: [
          BasicButton(
              isColor: true,
              text: 'ガチャを引く',
              onPressed: () {
                // ガチャを引く
              }),
          BasicButton(
              isColor: false,
              text: 'ガチャを引く',
              onPressed: () {
                // ガチャを引く
              }),
        ],
      )
      // せりふ
    ]);
  }
}
