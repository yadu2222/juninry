import 'package:flutter/material.dart';
import '../../components/atoms/shortcut_bottun.dart';

// ショートカットの4つセット
class ShortcutSet extends StatelessWidget {
  const ShortcutSet({super.key, required this.shortcutList, required this.icons, required this.movePages});

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
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
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
          ),
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
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
              ))
        ]));
  }
}
