import 'package:flutter/cupertino.dart';

class AlertDialogView extends StatelessWidget {
  final String? title;
  final String text;
  final Map<String, void Function()> actions;

  const AlertDialogView({
    super.key,
    this.title,
    required this.text,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title != null ? Text(title!) : null,
      content: Text(text),
      actions: actions.entries.map((action) {
        return CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            action.value();
            Navigator.of(context).pop();
          },
          child: Text(action.key),
        );
      }).toList(),
    );
  }
}
