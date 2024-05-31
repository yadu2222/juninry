import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/molecule/home_view.dart';
import './page_sample.dart';

class PageHomeJunior extends StatelessWidget {
  const PageHomeJunior({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScreenView(
        title: 'ホーム',
        widget: Center(
            child: ElevatedButton(
          onPressed: () {
            // ボタンを押したときの処理
            // 遷移
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageSample()),
            );
          },
          child: const Text(
            '遷移するよ',
            style: Fonts.h2,
          ),
        )));
  }
}
