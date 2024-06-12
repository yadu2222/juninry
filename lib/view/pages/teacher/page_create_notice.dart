
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/classes.dart';
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

class PageCreateNotice extends HookWidget {
  const PageCreateNotice({super.key});

  final String title = 'お知らせ作成';

  @override
  Widget build(BuildContext context) {
    //TODO: どうにかしてクラスリストを取ってくる
    final classesList = SampleData.classesData;

    //選択されているクラスのIDを監視するという気持ち
    var selectedClass = useState<Classes>(classesList[0]);

    void onChanged(Classes? value) {
      selectedClass.value = value!;
      print((value?.className ?? "") + (value?.classUuid ?? ""));
    }

    // 1ページに必要な要素を並べる
    return BasicTemplate(title: "お知らせ作成", children: [
      // お知らせ作成フォーム
      CreateNoticeForm(
          classesList: classesList,
          onChanged: onChanged,
          selectedClass: selectedClass.value),

      //ボタン
      Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            BasicButton(
              text: "下書きに保存",
              onPressed: () {},
              isColor: true,
            ),
            BasicButton(
              text: "投稿",
              isColor: false,
              onPressed: () {},
            ),
          ],
        ),
      )
    ]);
  }
}
