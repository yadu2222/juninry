import 'package:flutter/material.dart';
import '././../../../constant/fonts.dart';

import '../../components/atoms/appbar.dart';

class PageSample extends StatelessWidget {
  const PageSample({Key? key}) : super(key: key);

final String title = 'さんぷる';
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            children: [ 
            AppBarView(titleText: title),
            Text('いどうしたよ', style: Fonts.h3),
            ])
        );
  }
}
