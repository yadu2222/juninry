import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
// import 'package:go_router/go_router.dart';

// view
import '../../components/template/basic_template.dart';

class PageGatya extends HookWidget {
  PageGatya({super.key});

  final String title = 'ガチャ';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ouchiPoint = useState<int>(220); // ouchipoint

    void gatya(bool isFirst) async {
      int needPoint = isFirst ? 20 : 200;
      String defPointStr = "ポイントが不足しています";
      // ポイントが足りているか確認
      // ダイアログを表示
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            // useStateを使えないのでstatefulで対応
            return AlertDialog(
                elevation: 0.0, // ダイアログの影を削除
                backgroundColor: Colors.transparent, // 背景色
                contentPadding: const EdgeInsets.all(0),
                content: Container(
                    height: 150,
                    width: 450,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      const Text("ガチャを回しますか？"),
                      // Text(isFirst ? "1回20P" : "11回200P"),
                      BasicButton(
                          onPressed: () {
                            if (ouchiPoint.value >= needPoint) {
                              Navigator.pop(context);
                              context.go("/nyariot/gatya/gatyagatya", extra: {'isFirst': isFirst});
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          width: 0.7,
                          text: isFirst
                              ? ouchiPoint.value >= needPoint
                                  ? "1回20P"
                                  : defPointStr
                              : ouchiPoint.value >= needPoint
                                  ? "11回200P"
                                  : defPointStr,
                          isColor: ouchiPoint.value >= needPoint)
                    ])));
          });
    }

    useEffect(() {
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      Expanded(
          child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              // decoration: BoxDecoration(
              //     color: AppColors.iconLight,
              //     // border: Border.all(color: AppColors.iconLight),
              //     borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                Image.asset("assets/images/haikei.png", fit: BoxFit.contain),
                Column(children: [
                  SizedBox(
                      width: 500,
                      height: 500,
                      child: Image.asset(
                        'assets/images/gatya.png',
                        width: 200,
                        fit: BoxFit.contain,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            gatya(true);
                          },
                          child: Image.asset(
                            "assets/images/1_button.png",
                            height: 60,
                          )),
                      const SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            gatya(false);
                          },
                          child: Image.asset(
                            "assets/images/11_button.png",
                            height: 60,
                          ))
                    ],
                  )
                ])
              ])
              // せりふ
              ))
    ]);
  }
}
