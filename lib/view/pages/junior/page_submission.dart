import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';
import '../../components/molecule/divider.dart';
import '../../components/atoms/basic_button.dart';

// import '../../../models/homework_model.dart';
import '../../components/template/basic_template.dart';
import '../../../constant/sample_data.dart'; // sampleData

// 提出ページ
class PageSubmissionJunior extends HookWidget {
  final String homeworkUUId;
  const PageSubmissionJunior({
    super.key,
    required this.homeworkUUId,
  });

  final String title = '提出';

  @override
  Widget build(BuildContext context) {

    // TODO: ここでIDを元に提出が必要な課題データを取得する処理を追加

    // useStateでステート管理したい変数を定義する
    final counter = useState<int>(SampleData.homeworkData[0].pageCount); //  画像の枚数
    void incrementCounter() {     // カウンターをインクリメントする関数
      counter.value--;
    }
    bool isCounter(){  // 現在のカウントの状態を判別
      if(counter.value == 0){
        return true;
      }else{
        return false;
      }
    }

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      HomeworkCard(homeworkData: SampleData.homeworkData[0]), // 課題カード
      const DividerView(), // 区切り線
      // 提出リスト
      Expanded(
          child: SubmittionList(
        homeworkData: SampleData.homeworkData[0],
        onTakeCamera: () {
          incrementCounter();
        },
      )), // 提出リスト

      // 状態を元に提出ボタンを呼び出し
      isCounter() ? BasicButton(text: "提出", onPressed: () {},isColor: true,) :
      BasicButton(text: "あと${counter.value.toString()}枚", isColor: false, onPressed: () {})
    ]);
  }
}
