import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/collection_model.dart';
import 'package:juninry/view/components/atoms/alert_dialog.dart';
import 'package:juninry/view/components/atoms/dialog.dart';
import 'package:juninry/view/components/molecule/collection_box.dart';
import 'package:juninry/view/components/molecule/progress_bar.dart';
import 'package:juninry/view/components/template/basic_template.dart';

// 現在おねだり中のリスト
class PageNyariot extends HookWidget {
  const PageNyariot({super.key});

  final String title = 'おせわ';
  @override
  Widget build(BuildContext context) {
    // 画像ファイルを取得
    final nyariotImage = useState<String>('assets/images/cat.png');
    // セリフを取得
    final talk = useState<String>('ぼくはニャリオット！\nおなかがすいたニャ！\nごはんをくれニャ！');
    final itemCollections = useState<List<Collection>>(Collection.itemCollection);

    // たべものダイアログを表示
    void showMealDialog() {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            // useStateを使えないのでstatefulで対応
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                elevation: 0.0, // ダイアログの影を削除
                backgroundColor: Colors.transparent, // 背景色

                content: Container(
                    height: 400,
                    width: 500,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.main,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      const Text("なにをあげますか？", style: Fonts.h5),
                      Expanded(
                          child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: ListView(children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text("ガチャを回してたべものを手に入れましょう", style: Fonts.p),
                                    ),
                                    Wrap(
                                        children: itemCollections.value.map((collection) {
                                      return collection.quantity != 0 ? Column(children: [CollectionBox(imagePath: collection.imgPath), Text(collection.name, style: Fonts.p)]) : const SizedBox.shrink();
                                    }).toList())
                                  ]))))
                    ])));
          });
    }

    return BasicTemplate(title: title, children: [
      Expanded(
          child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              // decoration: BoxDecoration(
              //     color: AppColors.iconLight,
              //     // border: Border.all(color: AppColors.iconLight),
              //     borderRadius: BorderRadius.circular(10)),
              child: Stack(children:[

                Image.asset("assets/images/haikei.png"),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ガチャ
                      InkWell(
                          onTap: () {
                            // ガチャ画面に遷移
                            context.go("/nyariot/gatya");
                          },
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset("assets/images/gatya_icon.png", fit: BoxFit.contain),
                          )),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 左寄せに設定
                        children: [
                          Text(
                            'まんぷくメーター',
                            style: Fonts.p,
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ProgressBar(
                                progress: 0.3,
                                width: 0.6,
                              ))
                        ],
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    InkWell(
                        onTap: () {
                          // ごはん画面に遷移
                          showMealDialog();
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset("assets/images/meal_icon.png", fit: BoxFit.contain),
                        )),
                    // 図鑑
                    InkWell(
                        onTap: () {
                          // 図鑑画面に遷移
                          context.go("/nyariot/collection");
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset("assets/images/collection_icon.png", fit: BoxFit.contain),
                        ))
                  ]),

                  // せりふ
                  Stack(children: [
                    SizedBox(
                        width: 450,
                        height: 120,
                        child: Image.asset(
                          'assets/images/babul.png',
                          fit: BoxFit.contain,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        talk.value,
                        style: Fonts.p,
                      ),
                    ),
                    Column(children: [
                      const SizedBox(
                        height: 70,
                      ),
                      // ニャリオットの画像を表示
                      SizedBox(
                          width: 400,
                          height: 350,
                          child: Image.asset(
                            nyariotImage.value,
                            width: 200,
                            fit: BoxFit.contain,
                          )),
                    ])
                  ])
                  // せりふ
                ],
              )]))),
    ]);
  }
}
