import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';
import '../../components/atoms/listitem.dart';

class SampleListItem extends StatelessWidget {
  const SampleListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListItemBox(
      height: 50.0,
      // ここに箱の中に表示したいウィジェットを入れる
      widget: Text(
        'さんぷる',
        style: Fonts.p,
      ),
    );
  }
}
