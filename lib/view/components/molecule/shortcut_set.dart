import 'package:flutter/material.dart';
import '../../components/atoms/shortcut_bottun.dart';

class ShortcutSet extends StatelessWidget {
  const ShortcutSet({Key? key, required this.shortcutList, required this.icons, required this.movePages}) : super(key: key);

  final List<String> shortcutList;
  final List<IconData> icons;
  final List<String> movePages;

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(10),

        // TODO:ぶすすぎるので修正したい
        margin: const EdgeInsets.only(
          left: 8,
          right: 5,
        ),
        alignment: Alignment.center,
        child: Column(children: [
          Row(
            children: [
              ShortcutButton(
                icon: icons[0],
                title: shortcutList[0],
                movePage: movePages[0],
              ),
              ShortcutButton(
                icon: icons[1],
                title: shortcutList[1],
                movePage: movePages[1],
              ),
            ],
          ),
          Row(
            children: [
              ShortcutButton(
                icon: icons[2],
                title: shortcutList[2],
                movePage: movePages[2],
              ),
              ShortcutButton(
                icon: icons[3],
                title: shortcutList[3],
                movePage: movePages[3],
              ),
            ],
          )
        ]));
  }
}
