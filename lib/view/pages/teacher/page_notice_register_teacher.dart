import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/apis/controller/notice_req.dart';
import 'package:juninry/constant/messages.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/class_model.dart';
import 'package:juninry/models/drafted_notice_model.dart';
import 'package:juninry/view/components/atoms/alert_dialog_view.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/organism/create_notice_form.dart';
import 'package:juninry/view/components/template/basic_template.dart';
import '../../../models/user_model.dart';
import '../../../models/quoted_notice_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageNoticeRegisterTeacher extends HookWidget {
  // お知らせの下書きを管理する
  final int? draftedNoticeId;
  final String? quotedNoticeUuid;

  const PageNoticeRegisterTeacher({
    super.key,
    this.draftedNoticeId,
    this.quotedNoticeUuid,
  });

  final String title = 'お知らせ作成';

  @override
  Widget build(BuildContext context) {
    // TODO: 下書きがある状態で引用だけ設定したい時に、下書きが消される対策が必要
    final future =
        useMemoized(() => _loadData(), [draftedNoticeId, quotedNoticeUuid]);
    // 非同期通信が必要なデータ群
    final snapshot = useFuture(future);

    // ロード中の表示
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const BasicTemplate(title: "お知らせ作成", children: [
        Center(child: CircularProgressIndicator()),
      ]);
    }
    // エラーが発生した場合の表示
    if (snapshot.hasError) {
      return BasicTemplate(title: "お知らせ作成", children: [
        Center(child: Text('エラーが発生しました: ${snapshot.error}')),
      ]);
    }

    // データが null の場合の処理
    if (!snapshot.hasData) {
      return const BasicTemplate(title: "お知らせ作成", children: [
        Center(child: Text('データが見つかりません')),
      ]);
    }

    // 値を格納する
    final data = snapshot.data!;
    final classesList = data.classesList;
    final selectedClass = useState<Class>(data.selectedClass);
    final draftedNoticeData = data.draftedNoticeData;
    final quotedNoticeData = data.quotedNoticeData;
    final titleController = data.titleController;
    final textController = data.textController;

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
              dateTime: draftedNoticeData.draftedNoticeDate,
              classesList: classesList, //クラスリスト
              onClassChanged: onClassChanged, //クラス選択時の処理
              selectedClass: selectedClass.value, //現在選択されているクラス
              userName: data.userName, //名前
              titleController: titleController, //タイトルを管理するコントローラー
              textController: textController, //本文を管理するコントローラー
              quoteNoticeTitle: quotedNoticeData?.quotedNoticeTitle, //引用元のタイトル
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
                  onPressed: () async {
                    draftedNoticeData.selectedClass = selectedClass.value;
                    draftedNoticeData.draftedNoticeTitle = titleController.text;
                    draftedNoticeData.draftedNoticeExplanatory =
                        textController.text;
                    // これいらんかも
                    draftedNoticeData.quotedNoticeUuid =
                        quotedNoticeData?.quotedNoticeUuid;
                    // 下書き保存処理
                    int saveId;
                    // タイトルと本文が入力されていない場合は保存しない
                    if (draftedNoticeData.draftedNoticeTitle != "" ||
                        draftedNoticeData.draftedNoticeExplanatory != "") {
                      saveId = await DraftedNotice.saveDraftedNotice(
                          draftedNoticeData);
                      if (saveId > 0) {
                        draftedNoticeData.draftedNoticeId = saveId;
                        showDialog(
                            // 保存成功
                            context: context,
                            builder: (context) {
                              return AlertDialogView(
                                  title: Messages.draft,
                                  text: Messages.draftMsg,
                                  actions: {
                                    "OK": () {
                                      context.go('/notice/draft');
                                    }
                                  });
                            });
                      } else {
                        showDialog(
                            // 保存失敗ダイアログ
                            context: context,
                            builder: (context) {
                              return AlertDialogView(
                                  title: Messages.databaseError,
                                  text: Messages.databaseErrorMsg,
                                  actions: {"いいよ〜": () {}});
                            });
                      }
                    } else {
                      showDialog(
                          // 保存不可ダイアログ
                          context: context,
                          builder: (context) {
                            return AlertDialogView(
                                title: Messages.inputError,
                                text: Messages.inputErrorMsg,
                                actions: {"戻る": () {}});
                          });
                    }
                    // ダイアログを出す
                  },
                  isColor: true,
                  circular: 5,
                ),
                BasicButton(
                  widthPercent: 0.4,
                  text: "投稿",
                  isColor: false,
                  onPressed: () {
                    context.push('/notice/register');
                  }, //TODO: 投稿処理
                  icon: Icons.check,
                  circular: 5,
                )
              ],
            ),
          )
        ]);
  }

  Future<_PageData> _loadData() async {
    // 前回の値を取得しているやつっぽいけどわからん、、、
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedDraftedNoticeId = prefs.getInt('draftedNoticeId');

    DraftedNotice draftedNoticeData;
    QuotedNotice? quotedNoticeData;

    // draftedNoticeIdとquotedNoticeUuidの両方がnullの場合、新しい下書きを作成
    if (draftedNoticeId == null && quotedNoticeUuid == null) {
      draftedNoticeData = DraftedNotice();
      // 保存されていたIDをクリア
      await prefs.remove('draftedNoticeId');
    } else {
      // 適用する下書きIDを決定
      // 優先度 引用された下書き > 保存されていた下書き
      int? currentDraftedNoticeId = draftedNoticeId ?? storedDraftedNoticeId;
      debugPrint("適用する下書きID: $currentDraftedNoticeId");
      if (currentDraftedNoticeId != null) {
        // 既存の下書きを取得
        draftedNoticeData =
            await DraftedNotice.getDraftedNotice(currentDraftedNoticeId);
      } else {
        // 新しい下書きを作成
        draftedNoticeData = DraftedNotice();
      }

      // 新しい引用が提供された場合、下書きに引用IDを設定
      if (quotedNoticeUuid != null) {
        draftedNoticeData.quotedNoticeUuid = quotedNoticeUuid;
      }

      // // 現在の下書きIDを保存
      if (draftedNoticeData.draftedNoticeId != null) {
        await prefs.setInt('draftedNoticeId', draftedNoticeData.draftedNoticeId!);
      }
    }

    // 引用データを取得
    if (draftedNoticeData.quotedNoticeUuid != null) {
      debugPrint("引用IDチェック: ${draftedNoticeData.quotedNoticeUuid}");
      quotedNoticeData = await NoticeReq.fetchQuotedNotice(
          draftedNoticeData.quotedNoticeUuid!);
    }

    // コントローラーの設定
    final titleController =
        TextEditingController(text: draftedNoticeData.draftedNoticeTitle ?? '');
    final textController = TextEditingController(
        text: draftedNoticeData.draftedNoticeExplanatory ?? '');

    // クラスリストを作成
    // TODO: クラス一覧取得API
    List<Class> classesList = (quotedNoticeData != null)
        ? [quotedNoticeData.quotedClass]
        : SampleData.classesData;

    // 選択されているクラスを設定
    Class selectedClass = quotedNoticeData?.quotedClass ??
        draftedNoticeData.selectedClass ??
        classesList.first;

    // ユーザー名を取得
    final user = await User.getUser();

    return _PageData(
      classesList: classesList,
      selectedClass: selectedClass,
      draftedNoticeData: draftedNoticeData,
      quotedNoticeData: quotedNoticeData,
      titleController: titleController,
      textController: textController,
      userName: user.userName,
    );
  }
}

class _PageData {
  final List<Class> classesList;
  final Class selectedClass;
  final DraftedNotice draftedNoticeData;
  final QuotedNotice? quotedNoticeData;
  final TextEditingController titleController;
  final TextEditingController textController;
  final String userName;

  _PageData({
    required this.classesList,
    required this.selectedClass,
    required this.draftedNoticeData,
    required this.quotedNoticeData,
    required this.titleController,
    required this.textController,
    required this.userName,
  });
}
