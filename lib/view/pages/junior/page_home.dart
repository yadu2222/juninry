import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/molecule/basic_view.dart';

class PageHomeJunior extends StatelessWidget {
  const PageHomeJunior({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScreenView(
      title: 'ホーム',
      widget: const Center(
        child: Text('ホーム', style: Fonts.h1),
      ),
    );
  }
}
