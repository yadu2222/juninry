import 'package:flutter/material.dart';
import '../atoms/appbar.dart';
import '../atoms/screenview.dart';
import '../atoms/bottombar.dart';

class BasicScreenView extends StatelessWidget {
  const BasicScreenView({
    super.key,
    required this.title,
    required this.widget,
    this.featureIconButton,
  });

  final String title;
  final Widget widget;
  final IconButton? featureIconButton;
  // final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      appBar: AppBarView(
        titleText: title,
      ),
      widget: widget,
      bottomBar: BottomBarView(
        selectedIndex: 0,
        onItemTapped: (int index) {
          // onChanged(index);
        },
      ),
    );
  }
}
