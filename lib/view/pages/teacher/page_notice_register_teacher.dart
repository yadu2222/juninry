import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/class_model.dart';
import 'package:juninry/models/notice_model.dart';
import 'package:juninry/models/drafted_notice_model.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/organism/create_notice_form.dart';
import 'package:juninry/view/components/template/basic_template.dart';
import '../../../models/user_model.dart';

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
    // クラス一覧取得
    // 引用されたお知らせがある場合クラスの選択肢は引用されたクラスになる
    final List<Class> classesList = (draftedNoticeData?.quotedNotice != null)
        // あるとき〜！
        ? [
            draftedNoticeData!.quotedNotice!.quotedClass,
          ]
        // ないとき；；
        //TODO: どうにかしてクラスリストを取ってくる 多分fetchで所属クラス一覧を取ってくるメソッド
        : SampleData.classesData;

    //名前を取得
    //TODO: どうにかして名前を取ってくる
    final String name;

    // クラス監視　優先度 引用と同じクラス > 下書きクラス > 初期値
    // useStateの初期化は一生に一度しか発生しないのでここでいろいろしても意味ない
    var selectedClass = useState<Class>(classesList[0]);

    // ページに戻ってきた時に送られてきたデータを元にクラスを選択する
    useEffect(() {
      selectedClass.value = draftedNoticeData?.quotedNotice?.quotedClass ??
          draftedNoticeData?.selectedClass ??
          classesList[0];
    }, [draftedNoticeData]);

    // タイトルの値を管理するコントローラー
    TextEditingController titleController =
        TextEditingController(text: draftedNoticeData?.noticeTitle ?? "");

    // 本文の値を管理するコントローラー
    TextEditingController textController =
        TextEditingController(text: draftedNoticeData?.noticeExplanatory ?? "");

    //クラス選択時の処理
    void onClassChanged(Class value) {
      selectedClass.value = value;
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
          // TODO: Routing 下書き画面へ
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
              titleController: titleController, //タイトルを管理するコントローラー
              textController: textController, //本文を管理するコントローラー
              quoteNoticeTitle:
                  draftedNoticeData?.quotedNotice?.quotedNoticeTitle, //引用元のタイトル
            ),
          ),

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
                    //TODO: 下書き保存処理
                    // IDがあれば更新、なければ新規作成
                    print(DraftedNotice.saveDraftedNotice(
                      DraftedNotice(
                        noticeId: draftedNoticeData
                            ?.noticeId, // 送られたきたデータにnotice_idがあれば送る
                        selectedClass: selectedClass.value,
                        noticeTitle: titleController.text,
                        noticeExplanatory: textController.value.text,
                        quotedNotice: draftedNoticeData
                            ?.quotedNotice, // 送られたきたデータに引用元があれば送る
                      ),
                    ));
                  },
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
