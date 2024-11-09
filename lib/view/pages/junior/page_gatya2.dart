import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/collection_model.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/molecule/collection_box.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

import '../../components/template/basic_template.dart';

class PageGatyaGatya extends HookWidget {
  const PageGatyaGatya({
    super.key,
    required this.isFirst,
  });

  final String title = 'ガチャ';
  final isFirst;

  @override
  Widget build(BuildContext context) {
    // final imgPath = useState<String>("assets/images/close_treasure.png");
    final AnimationController controller = useAnimationController();
    final isMoved = useState<bool>(false);
    final collections = useState<List<Collection>>(isFirst ? Collection.testCollection : Collection.nyariotCollection);

    // ガチャ結果
    void _animateAndShowDialog() {
      isMoved.value = true;
      // アニメーションが終了するまで待機し、その後ダイアログを表示
      Future.delayed(Duration(milliseconds: isFirst ? 600 : 1700), () {
        if (isMoved.value) {
          // アニメーションが実行された場合にのみダイアログを表示
          // _showCompletionDialog(context);
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
                        height: isFirst ? 200 : 470,
                        width: 450,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.main,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          const Text("ガチャ結果", style: Fonts.h5),
                          Wrap(
                              children: collections.value.map((collection) {
                            return CollectionBox(imagePath: collection.imgPath);
                          }).toList()),
                          BasicButton(
                              isColor: true,
                              text: "OK",
                              onPressed: () {
                                // ダイアログをとじる
                                Navigator.of(context).pop();
                                // 画面を一つ戻す
                                context.pop(context);
                              })
                        ])));
              });
        }
      });
    }

    useEffect(() {
      return () {};
    }, []);

    Widget kirakira = Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(10),
      child: Lottie.asset(
        'assets/lotties/kirakira.json', // Lottieファイルのパス
        controller: controller,
        onLoaded: (composition) {
          controller.duration = composition.duration;
          controller.repeat();
        },
      ),
    );

    Widget card = Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(5),
      color: AppColors.iconLight,
      child: Center(
          child: Image.asset(
        "assets/images/stamp.png",
        fit: BoxFit.contain,
      )),
    );

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      ElevatedButton(
          onPressed: () {
            if (!isMoved.value) {
              _animateAndShowDialog();
            }
          },
          child: Stack(children: [
            Column(children: [kirakira, kirakira, kirakira]),
            // containerを下から上にとばす
            AnimatedPositioned(
                //  アニメーションの速度を調整
                duration: isFirst ? const Duration(milliseconds: 600) : const Duration(milliseconds: 1700),
                curve: Curves.easeInOut,
                left: MediaQuery.of(context).size.width / 2 - 90,
                bottom: isMoved.value
                    ? isFirst
                        ? MediaQuery.of(context).size.height - 200
                        : MediaQuery.of(context).size.height - 50
                    : isFirst
                        ? -200
                        : -1500,
                child: isFirst
                    ? card
                    : Column(
                        children: [
                          card,
                          card,
                          card,
                          card,
                          card,
                          card,
                          card,
                          card,
                          card,
                          card,
                          card,
                        ],
                      )),
          ]))
    ]);
  }
}
