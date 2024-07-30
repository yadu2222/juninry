import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// API呼び出し
import '../../../apis/controller/class_req.dart';
import '../../../apis/controller/notice_req.dart';
// 表示する文字たち
import '../../../constant/messages.dart';
// モデル
import '../../../models/class_model.dart';
import '../../../models/user_model.dart';
import '../../../models/drafted_notice_model.dart';
import '../../../models/quoted_notice_model.dart';
import '../../../models/notice_model.dart';
// コンポーネント
import '../../components/atoms/basic_button.dart';
import '../../components/organism/create_notice_form.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/toast.dart';
import '../../components/atoms/alert_dialog.dart';

class PageNoticeRegisterTeacher extends HookWidget {
  // お知らせの下書きを管理する
  final int? draftedNoticeId;
  final String? quotedNoticeUUID;
  final bool newNotice;

  const PageNoticeRegisterTeacher({
    super.key,
    this.draftedNoticeId,
    this.quotedNoticeUUID,
    bool? newNotice,
  }) : newNotice = newNotice ?? false;

  final String title = 'お知らせ作成';

  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // 通信用クラスのインスタンスを生成
    NoticeReq noticeReq = NoticeReq(context: context); // 通信用クラスのインスタンスを生成

    final future = useMemoized(() => _loadData(context, classReq, noticeReq),
        [draftedNoticeId, quotedNoticeUUID]);
    // 非同期通信が必要なデータ群
    final snapshot = useFuture(future);

    // ロード中の表示
    if (snapshot.connectionState == ConnectionState.waiting) {
      return BasicTemplate(title: title, children: const [
        Center(child: CircularProgressIndicator()),
      ]);
    }
    // エラーが発生した場合の表示
    if (snapshot.hasError) {
      context.go('/notice');
    }

    // データが null の場合の処理
    if (!snapshot.hasData) {
      return BasicTemplate(title: title, children: const [
        Center(child: Text(Messages.isEmpty)),
      ]);
    }

    // 値を格納する
    final data = snapshot.data!;
    final classesList = useState<List<Class>>(data.classesList);
    final selectedClass = useState<Class>(data.selectedClass);
    final draftedNoticeData = data.draftedNoticeData;
    final quotedNoticeData = useState(data.quotedNoticeData);
    final titleController = data.titleController;
    final textController = data.textController;

    // 遷移処理する時に前回の値保存してほしいなぁ
    useEffect(() {
      // 保存されていたIDをクリア
      // await prefs.remove('draftedNoticeId');
      return () {
        debugPrint("\na\ni\nu\ne\na\ni\ne\no");

        debugPrint("data: ${data.draftedNoticeData.draftedNoticeId}");
        // ページを離れる際にdraftedNoticeIdを保存
        if (data.draftedNoticeData.draftedNoticeId != null) {
          data.cache.setInt(
              'draftedNoticeId', data.draftedNoticeData.draftedNoticeId!);
          debugPrint("保存された");
        } else {
          data.cache.remove('draftedNoticeId');
          debugPrint("削除された");
        }
      };
    }, [context]);

    // DBから拾ってきた文字列を置いといて保存必要かみてみる
    final String titleString = draftedNoticeData.draftedNoticeTitle.toString();
    final String textString =
        draftedNoticeData.draftedNoticeExplanatory.toString();

    // セーブ処理をする 返り血は成功したID
    Future<bool> save() async {
      draftedNoticeData.selectedClass = selectedClass.value;
      draftedNoticeData.draftedNoticeTitle = titleController.text;
      draftedNoticeData.draftedNoticeExplanatory = textController.text;
      // これいらんかも おまもり
      draftedNoticeData.quotedNoticeUuid =
          quotedNoticeData.value?.quotedNoticeUuid;
      // 下書き保存処理
      int saveId;
      // タイトルが入力されていない場合は保存しない
      if (draftedNoticeData.draftedNoticeTitle != "") {
        saveId = await DraftedNotice.saveDraftedNotice(draftedNoticeData);
        // 保存できた時はIDを返す
        if (saveId > 0) {
          draftedNoticeData.draftedNoticeId = saveId;
          return true;
        } else {
          // 保存失敗ダイアログ
          ToastUtil.show(message: Messages.databaseErrorMsg);
        }
      } else {
        // 保存不可ダイアログ
        ToastUtil.show(message: Messages.noticeTitleIsEmpty);
      }

      return false;
    }

    //クラス選択時の処理
    void onClassChanged(Class value) {
      selectedClass.value = value;
    }

    // 引用ボタン押した時に保存を促す
    void onQuoteClicked() {
      if ((titleController.text != titleString && titleController.text != "") ||
          (textController.text != textString && textController.text != "")) {
        AlertDialogUtil.show(
          context: context,
          content: Messages.confirmationMsg,
          negativeAction: (
            "無視する",
            () {
              context.go('/notice/register/quote');
            }
          ),
          positiveAction: (
            "保存する",
            () async {
              if (await save()) {
                // 引用から戻ってきた時のために保存しとく
                await SharedPreferences.getInstance().then((value) {
                  value.setInt('draftedNoticeId',
                      data.draftedNoticeData.draftedNoticeId!);
                });
                context.go('/notice/register/quote');
              }
            }
          ),
        );
      } else {
        context.go('/notice/register/quote');
      }
    }

    // 引用の削除
    void onDeleteClicked() async {
      data.cache.remove('quotedNoticeUUID');
      quotedNoticeData.value = null;
      classesList.value = await classReq.getClassesHandler();
    }

    // 1ページに必要な要素を並べる
    return BasicTemplate(
        title: title,
        popIcon: true,
        featureIconButton: IconButton(
          icon: const Icon(
            Icons.note_add_outlined,
            size: 32,
          ),
          onPressed: () {
            context.go("/notice/register/draft");
          },
        ),
        children: [
          // お知らせ作成フォーム
          Expanded(
              child: CreateNoticeForm(
                  classesList: classesList.value, //クラスリスト
                  onClassChanged: onClassChanged, //クラス選択時の処理
                  selectedClass: selectedClass.value, //現在選択されているクラス
                  userName: data.userName, //名前
                  titleController: titleController, //タイトルを管理するコントローラー
                  textController: textController, //本文を管理するコントローラー
                  quoteNoticeTitle:
                      quotedNoticeData.value?.quotedNoticeTitle, //引用元のタイトル
                  onQuoteClicked: onQuoteClicked, // 引用ボタン押した時の処理
                  onDeleteClicked: onDeleteClicked)),
          //ボタン
          Align(
              heightFactor: 1.3,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BasicButton(
                      width: 0.4,
                      text: "下書きに保存",
                      onPressed: () async {
                        // 保存できた時はIDを下書きデータに格納する　※上書き保存のため
                        if (await save()) {
                          AlertDialogUtil.show(
                              context: context,
                              content: Messages.draftMsg,
                              neutralAction: (
                                "OK",
                                () {
                                  context.go('/notice/register/draft');
                                }
                              ));
                        }
                      },
                      isColor: true,
                      circular: 5,
                    ),
                    BasicButton(
                      width: 0.4,
                      text: "投稿",
                      isColor: false,
                      onPressed: () async {
                        bool result = await noticeReq.postNoticeHandler(Notice(
                          noticeTitle: titleController.text,
                          noticeExplanatory: textController.text,
                          quotedNoticeUUID:
                              quotedNoticeData.value?.quotedNoticeUuid,
                          classUUID: selectedClass.value.classUUID!,
                        ));

                        if (result) {
                          // 下書きから破壊
                          if (draftedNoticeData.draftedNoticeId != null) {
                            await DraftedNotice.deleteDraftedNotice(
                                draftedNoticeData.draftedNoticeId!);
                          }
                          // 投稿成功
                          AlertDialogUtil.show(
                              context: context,
                              content: Messages.postNoticeSuccess,
                              neutralAction: (
                                "OK",
                                () {
                                  context.go('/notice');
                                }
                              ));
                        }
                      },
                      icon: Icons.check,
                      circular: 5,
                    )
                  ],
                ),
              ))
        ]);
  }

  Future<_PageData> _loadData(
      context, ClassReq classReq, NoticeReq noticeReq) async {
    // _loadDataの一部
    DraftedNotice draftedNoticeData;
    QuotedNotice? quotedNoticeData;

    // SharedPreferencesからdraftedNoticeIdを取得
    SharedPreferences cache = await SharedPreferences.getInstance();

    // お知らせ一覧から遷移してきたときは新規作成
    if (newNotice) {
      draftedNoticeData = DraftedNotice();

      // 保存されていたデータを削除
      cache.remove('draftedNoticeId');
      cache.remove('quotedNoticeUUID');
    }

    if (draftedNoticeId != null) {
      cache.remove('quotedNoticeUUID');
    }
    
    // 前回の値を拾うよ
    int? storedDraftedNoticeId = cache.getInt('draftedNoticeId');
    String? storedQuotedNoticeUUID = cache.getString('quotedNoticeUUID');

    // 管理めんどいのでまとめる
    int? currentDraftedNoticeId = draftedNoticeId ?? storedDraftedNoticeId;
    String? currentQuotedNoticeUUID =
        quotedNoticeUUID ?? storedQuotedNoticeUUID;

    // 下書きのIDがある場合は、その下書きを取得　なかったら新規作成
    if (currentDraftedNoticeId != null) {
      draftedNoticeData =
          await DraftedNotice.getDraftedNotice(currentDraftedNoticeId);
      // 次回参照できるように保存
      cache.setInt('draftedNoticeId', draftedNoticeData.draftedNoticeId!);
    } else {
      draftedNoticeData = DraftedNotice();
    }

    // 引用UUID がある場合は、下書きに入れる
    if (currentQuotedNoticeUUID != null) {
      draftedNoticeData.quotedNoticeUuid = currentQuotedNoticeUUID;
      // 次回参照できるように保存
      cache.setString('quotedNoticeUUID', draftedNoticeData.quotedNoticeUuid!);
    }

    // 引用されているお知らせを取得する
    if (draftedNoticeData.quotedNoticeUuid != null) {
      quotedNoticeData = await noticeReq
          .fetchQuotedNoticeHandler(draftedNoticeData.quotedNoticeUuid!);
    }

    // HACK: 表示しないけどDBにいれるお知らせ作成日だよ
    draftedNoticeData.draftedNoticeDate =
        DateFormat('yyyy.MM.dd').format(DateTime.now());

    // コントローラーの設定
    final titleController =
        TextEditingController(text: draftedNoticeData.draftedNoticeTitle ?? '');
    final textController = TextEditingController(
        text: draftedNoticeData.draftedNoticeExplanatory ?? '');

    // クラスリストを作成
    List<Class> classesList = (quotedNoticeData != null)
        ? [quotedNoticeData.quotedClass]
        : await classReq.getClassesHandler();

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
      cache: cache,
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
  final SharedPreferences cache;

  _PageData({
    required this.classesList,
    required this.selectedClass,
    required this.draftedNoticeData,
    required this.quotedNoticeData,
    required this.titleController,
    required this.textController,
    required this.userName,
    required this.cache,
  });
}
