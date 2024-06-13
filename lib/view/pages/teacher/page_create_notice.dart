import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/classes.dart';
import 'package:juninry/models/notice_model.dart';
import 'package:juninry/view/components/atoms/appbar.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/atoms/shortcut_bottun.dart';
import 'package:juninry/view/components/molecule/notice_detail_tab.dart';
import 'package:juninry/view/components/organism/create_notice_form.dart';
import 'package:juninry/view/components/organism/student_list.dart';
import 'package:juninry/view/components/template/basic_template.dart';
import '../../components/molecule/divider.dart';
import '../../../constant/sample_data.dart';
import '../../../constant/fonts.dart';

//クラスの表示に必要なデータ型
import 'package:juninry/models/classes.dart';
import '../../../constant/colors.dart';
import '../../../constant/sample_data.dart';

class PageCreateNotice extends HookWidget {
  const PageCreateNotice({super.key});

  final String title = 'お知らせ作成';

  @override
  Widget build(BuildContext context) {
    // クラス一覧取得
    //TODO: どうにかしてクラスリストを取ってくる
    final classesList = SampleData.classesData;

    //名前を取得
    //TODO: どうにかして名前を取ってくる
    final String name = SampleData.user.userName;

    //引用元のデータを取得
    //TODO: どうにかして引用元のデータを取ってくる
    final String quoteNoticeTitle = SampleData.noticesData[0].noticeTitle;

    //選択されているクラスを監視するという気持ち
    var selectedClass = useState<Classes>(classesList[0]);

    //入力された内容を監視するという気持ち
    var noticeText = useState<String>("");

    //クラス選択時の処理
    void onChanged(Classes? value) {
      selectedClass.value = value!;
    }

    //テキスト入力時の処理
    void onTextChanged(String value) {
      noticeText.value = value;
    }

    // 1ページに必要な要素を並べる
    return BasicTemplate(title: "お知らせ作成", children: [
      // お知らせ作成フォーム
      CreateNoticeForm(
        classesList: classesList, //クラスリスト
        onChanged: onChanged, //クラス選択時の処理
        selectedClass: selectedClass.value, //現在選択されているクラス
        name: name, //名前
        quoteNoticeTitle: quoteNoticeTitle, //引用元のタイトル
        onTextChanged: onTextChanged, //入力された内容
      ),

      //ボタン
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicButton(
              text: "下書きに保存",
              onPressed: () {}, //TODO: 下書き保存処理
              isColor: true,
            ),
            BasicButton(
              text: "投稿",
              isColor: false,
              onPressed: () {}, //TODO: 投稿処理
              icon: Icons.check,
            ),
          ],
        ),
      ),
    ]);
  }
}
