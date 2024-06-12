import 'package:flutter/material.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../components/template/basic_template.dart';
import 'package:juninry/view/components/molecule/notice_detail_tab.dart';
import '../../components/atoms/basic_button.dart';

class PageNoticeDetailPatron extends HookWidget {
  final String noticeUUID;
  const PageNoticeDetailPatron({super.key, required this.noticeUUID});

  // fields
  final String title = "おしらせ詳細";

  // TODO:UUIDに合わせてお知らせデータを取得する処理

  @override
  Widget build(BuildContext context) {
    // useStateでステート管理したい変数を定義する
    // TODO:初期値を取得したお知らせデータから取得する
    final isRead = useState<bool>(SampleData.noticesData[0].noticeRead == '1');
    void isReadChange() {
      // TODO:お知らせ確認済をサーバーに送信する処理
      isRead.value = true; // trueに変更
    }

    return BasicTemplate(
        // app barのプロパティ
        title: title,
        popIcon: true, // 戻るボタン
        children: [
          // なかみ
          // TODO:文字数過多に対する処理
          NoticeDetailTab(tabData: SampleData.noticesData[0]), // 詳細
          isRead.value ? BasicButton(icon: Icons.check, text: '確認済', isColor: isRead.value) : BasicButton(icon: Icons.check, text: '確認しました', isColor: isRead.value, onPressed: isReadChange)
        ]);
  }
}
