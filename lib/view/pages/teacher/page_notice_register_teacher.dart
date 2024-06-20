import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/class_model.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/organism/create_notice_form.dart';
import 'package:juninry/view/components/template/basic_template.dart';

//クラスの表示に必要なデータ型

class PageNoticeRegisterTeacher extends HookWidget {
  // HACK: どっちかだけ来た場合にお知らせの引用がゴミになる
  // 引用されているお知らせID
  final String? quoteNoticeUuid;
  // 引用されているお知らせタイトル
  final String? quoteNoticeTitle;

  const PageNoticeRegisterTeacher({
    super.key,
    this.quoteNoticeUuid,
    this.quoteNoticeTitle,
  });

  final String title = 'お知らせ作成';

  @override
  Widget build(BuildContext context) {
    // クラス一覧取得
    //TODO: どうにかしてクラスリストを取ってくる
    final classesList = SampleData.classesData;

    //名前を取得
    //TODO: どうにかして名前を取ってくる
    final String name = SampleData.user.userName;

    //選択されているクラスを監視するという気持ち
    var selectedClass = useState<Class>(classesList[0]);

    //タイトルを監視するという気持ち
    var noticeTitle = useState<String>("");

    //入力された内容を監視するという気持ち
    var noticeText = useState<String>("");

    //クラス選択時の処理
    void onClassChanged(Class? value) {
      selectedClass.value = value!;
    }

    //タイトル入力時の処理
    void onTitleChanged(String value) {
      noticeTitle.value = value;
    }

    //テキスト入力時の処理
    void onTextChanged(String value) {
      noticeText.value = value;
    }

    // 1ページに必要な要素を並べる
    return BasicTemplate(
        title: "お知らせ作成",
        popIcon: true,
        featureIconButton: IconButton(
          icon: const Icon(
            Icons.note_add_outlined,
            size: 32,
          ),
          // TODO: 下書きに飛ぶ
          onPressed: () {
            context.push("/notice/draft");
          },
        ),
        children: [
          // お知らせ作成フォーム
          Expanded(
            child: CreateNoticeForm(
              classesList: classesList, //クラスリスト
              onClassChanged: onClassChanged, //クラス選択時の処理
              selectedClass: selectedClass.value, //現在選択されているクラス
              name: name, //名前
              onTitleChanged: onTitleChanged, //タイトル入力時の処理
              quoteNoticeTitle: quoteNoticeTitle, //引用元のタイトル
              onTextChanged: onTextChanged, //入力された内容
            ),
          ),

          // お知らせ作成フォーム

          //ボタン
          Align(
            heightFactor: 1.3,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BasicButton(
                  widthPercent: 0.4,
                  text: "下書きに保存",
                  onPressed: () {
                    context.push("/notice/draft", extra: {
                      "title": noticeTitle.value,
                      "class": selectedClass.value.className,
                      
                      "text": noticeText.value

                    });
                  }, //TODO: 下書き保存処理
                  isColor: true,
                  radius: 5,
                ),
                BasicButton(
                  widthPercent: 0.4,
                  text: "投稿",
                  isColor: false,
                  onPressed: () {}, //TODO: 投稿処理
                  icon: Icons.check,
                  radius: 5,
                )
              ],
            ),
          )
        ]);
  }
}
