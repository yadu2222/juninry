import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/molecule/progress_bar.dart';
import 'package:juninry/view/components/template/basic_template.dart';

// 現在おねだり中のリスト
class PageNyariot extends HookWidget {
  const PageNyariot({super.key});

  final String title = 'おせわ';
  @override
  Widget build(BuildContext context) {
    // 画像ファイルを取得
    // final nyariotImage = useState<String>('assets/images/IMG_0065.png');
    // セリフを取得
    // final talk = useState<String>('serifu');
    //

    return BasicTemplate(title: title, children: [
      Expanded(
          child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: AppColors.iconLight,
                  // border: Border.all(color: AppColors.iconLight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ガチャ
                      InkWell(
                          onTap: () {
                            // 図鑑画面に遷移
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
                          Text('まんぷくメーター'),
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
                          // 図鑑画面に遷移
                          context.go("/nyariot/meal");
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
                  const SizedBox(width: 400, height: 70, child: Text('serifu')),

                  // ニャリオットの画像を表示
                  SizedBox(
                      width: 400,
                      height: 350,
                      child: Image.asset(
                        'assets/images/IMG_0065.png',
                        width: 200,
                        fit: BoxFit.contain,
                      )),
                  // せりふ
                ],
              ))),
    ]);
  }
}
