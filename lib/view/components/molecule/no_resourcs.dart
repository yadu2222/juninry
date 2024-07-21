import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';


// なにもないときに表示するもの
// なんかもっとないんか？とおもっている 検討中
class NoResources extends StatelessWidget {
  const NoResources({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'からっぽです',
        style: Fonts.h4w,
      ),
    );
  }
}
