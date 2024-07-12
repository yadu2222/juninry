import 'package:flutter/material.dart';
import '../atoms/shortcut_bottun.dart';

class OuchiShortCuts extends StatelessWidget {
  const OuchiShortCuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 5,
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: const Row(children: [
        ShortcutButton(title: 'GOHOUBI', icon: Icons.auto_awesome, movePage: '/ouchi/reward'),
        ShortcutButton(title: 'ONEDARI', icon: Icons.auto_awesome, movePage: '/home'),
      ]),
    );
  }
}
