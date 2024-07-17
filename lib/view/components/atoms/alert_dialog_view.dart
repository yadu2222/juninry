import 'package:flutter/cupertino.dart';
import '../../../constant/fonts.dart';

class AlertDialogView extends StatelessWidget {
  final String? title;
  final String text;
  final Map<Widget, void Function()> actions;

  const AlertDialogView({
    super.key,
    this.title,
    required this.text,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title != null ? Text(title!, style: Fonts.h3) : null,
      content: Text(text, style: Fonts.p),
      actions: actions.entries.map((action) {
        return CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            action.value();
            Navigator.of(context).pop();
          },
          child: action.key,
        );
      }).toList(),
    );
  }
}
