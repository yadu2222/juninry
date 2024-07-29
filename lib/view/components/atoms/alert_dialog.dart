import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../constant/fonts.dart';


class AlertDialogUtil {
  static void show({
    required BuildContext context,
    String? title,
    required String content,
    (String, Function())? positiveAction,
    (String, Function())? negativeAction,
    (String, Function())? neutralAction,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title, style: Fonts.h3) : null,
          content: Text(content, style: Fonts.p),
          actions: [
            if (negativeAction != null)
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    negativeAction.$2();
                    Navigator.of(context).pop();
                  },
                  child: Text(negativeAction.$1, style: Fonts.pr),
                ),

            if (neutralAction != null)
              CupertinoDialogAction(
                  onPressed: () {
                    neutralAction.$2();
                    Navigator.of(context).pop();
                  },
                  child: Text(neutralAction.$1, style: Fonts.pg),
                )
              ,

            if (positiveAction != null)
                CupertinoDialogAction(
                  onPressed: () {
                    positiveAction.$2();
                    Navigator.of(context).pop();
                  },
                  child: Text(positiveAction.$1, style: Fonts.pb),
                )

          ],
        );
      },
    );
  }
}
