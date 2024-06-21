import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/class_model.dart';
import 'package:juninry/models/notice_model.dart';
import 'package:juninry/models/notice_register_model.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/organism/create_notice_form.dart';
import 'package:juninry/view/components/template/basic_template.dart';

//クラスの表示に必要なデータ型

class PageNoticeRegisterTeacher extends HookWidget {
  // 引用だとか、下書きだとか、いろいろ管理するやつだ！
  // なかったらつくろうね〜
  final DraftedNotice? draftedNoticeData;

  PageNoticeRegisterTeacher({
    super.key,
    this.draftedNoticeData,
  });

  final String title = 'お知らせ作成';

  @override
  Widget build(BuildContext context) {
    print(draftedNoticeData?.noticeTitle);
    // クラス一覧取得
    // 引用されたお知らせがある場合クラスの選択肢は引用されたクラスになる
    final List<Class> classesList = (draftedNoticeData?.quotedNotice != null)
        // あるとき〜！
        ? [
            draftedNoticeData!.quotedNotice!.quotedClassData,
          ]
        // ないとき；；
        //TODO: どうにかしてクラスリストを取ってくる 多分fetchで所属クラス一覧を取ってくるメソッド
        : SampleData.classesData;

    //名前を取得
    //TODO: どうにかして名前を取ってくる
    final String name = SampleData.teacherUser.userName;

    // 監視ブロック
    // クラス監視　優先度 引用と同じクラス > 下書きクラス > 初期値
    // TODO: 初期値はお知らせ作成ページに飛んだ時なんかあれば、、、
    // TODO: 値の反映ができない
    var selectedClass = useState<Class>(
        draftedNoticeData?.quotedNotice?.quotedClassData ??
            draftedNoticeData?.classData ??
            classesList[0]);
    //　タイトル監視　優先度 下書きタイトル > 初期値
    var noticeTitle = useState<String>(draftedNoticeData?.noticeTitle ?? "");
    // 　本文監視　優先度 下書き本文 > 初期値
    var noticeText =
        useState<String>(draftedNoticeData?.noticeExplanatory ?? "");

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
      print(noticeText.value);
    }

    // TODO: 値の反映ができない
    // 変数には入っているので描画が更新できていない気がする
    useEffect(() {
      selectedClass.value = draftedNoticeData?.quotedNotice?.quotedClassData ??
          SampleData.classesData[0];
      noticeTitle.value = draftedNoticeData?.noticeTitle ?? "";
      noticeText.value = draftedNoticeData?.noticeExplanatory ?? "";
    }, [draftedNoticeData]);

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
              quoteNoticeTitle:
                  draftedNoticeData?.quotedNotice?.quotedNoticeTitle, //引用元のタイトル
              onTextChanged: onTextChanged, //入力された内容
            ),
          ),

          // お知らせ作成フォーム
          Text(draftedNoticeData?.noticeTitle ?? ""),
          Text(noticeTitle.value),
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
                  //
                  onPressed: () {
                    // XXX: データの送信、
                    context.push("/notice/draft", extra: {
                      'draftedNoticeData': DraftedNotice(
                        classData: selectedClass.value,
                        noticeTitle: noticeTitle.value,
                        noticeExplanatory: noticeText.value,
                        quotedNotice: draftedNoticeData?.quotedNotice,
                      )
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
