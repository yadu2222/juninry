import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/sample_data.dart';
import 'package:juninry/models/notice_model.dart';
import 'package:juninry/router/router.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/organism/student_read_status_list.dart';
import '../../../apis/controller/notice_req.dart';
import '../../components/template/basic_template.dart';
import 'package:juninry/view/components/molecule/notice_detail_tab.dart';
import 'package:juninry/view/components/organism/student_list.dart';
import '../../components/molecule/divider.dart';
import 'package:go_router/go_router.dart';

class PageNoticeDetail extends HookWidget {
  final String noticeUuid;
  const PageNoticeDetail({super.key, required this.noticeUuid});

  // fields
  final String title = "おしらせ詳細";

  @override
  Widget build(BuildContext context) {
    final noticeReq = NoticeReq(context: context);

    // お知らせ管理
    final noticeState = useState(Notice.errorNotice());
    final quotedNoticeState = useState<(String, String)?>(null);
    final isLoading = useState(true);

    // 付随するウィジェットを管理
    final readWidget = useState<Widget>(const Placeholder());

    final isTeacher = useState(false);

    // ユーザータイプごとに表示するウィジェットを管理
    Future<Widget> setReadWidget() async {
      // ユーザータイプもろて
      final BranchType branch = await getBranchType();

      switch (branch) {
        // 教師は既読状態の一覧を表示
        case BranchType.teacher:
          isTeacher.value = true;
          return Column(
            children: [
              const DividerView(
                icon: Icons.menu_book_outlined,
                title: '確認状況',
              ),
              Expanded(child:
              // お知らせを確認した学生諸君
              StudentReadStatusList(
                studentData: await noticeReq.getStudentReadStatusHandler(noticeUuid), // ここではサンプルのList<map>を渡している
              ))
            ],
          );

        // 生徒は親の既読状態を表示
        case BranchType.junior:
          return Column(children: [
            const Spacer(),
            noticeState.value.readStatus == null
                ? const Spacer()
                : noticeState.value.readStatus == 1
                    ? const BasicButton(text: '確認済です', icon: Icons.check, isColor: true)
                    : const BasicButton(text: '未確認です', icon: Icons.error_outline, isColor: false)
          ]);

        // 親は既読通知を送信するボタンを表示
        case BranchType.patron:
          return Column(children: [
            const Spacer(),
            noticeState.value.readStatus == 1
                ? const BasicButton(text: '確認済です', icon: Icons.check, isColor: true)
                : BasicButton(
                    text: '確認済みにする',
                    icon: Icons.send,
                    iconSize: 20,
                    isColor: false,
                    onPressed: () async {
                      // 既読処理が完了したらお知らせを既読にする
                      if (await noticeReq.updateReadStatusHandler(noticeUuid)) {
                        noticeState.value.readStatus = 1;
                        readWidget.value = await setReadWidget(); // 再描画
                      }
                    })
          ]);
      }
    }

    // 詳細を取得し、ユーザータイプごとに付随ウィジェットを取得
    Future<void> getNoticeDetail() async {
      noticeState.value = await noticeReq.fetchNoticeDetailHandler(noticeUuid);
      readWidget.value = await setReadWidget();

      //　引用が設定されていた場合そのお知らせを取得
      if (noticeState.value.quotedNoticeUUID != null) {
        final resData = await noticeReq.fetchNoticeDetailHandler(noticeState.value.quotedNoticeUUID!);
        quotedNoticeState.value = (resData.noticeTitle, resData.noticeUUID!);
        debugPrint("引用されているお知らせを取得しました");
        debugPrint("引用されているお知らせのUUIDは${quotedNoticeState.value!.$2}");
        debugPrint("引用されているお知らせのタイトルは${quotedNoticeState.value!.$1}");
      }
      isLoading.value = false;
    }

    // 詳細を取得
    useEffect(() {
      getNoticeDetail();
      return null;
    }, [noticeUuid]);

    return BasicTemplate(
      // app barのプロパティ
      title: title,
      popIcon: true, // 戻るボタン
      featureIconButton: isTeacher.value
          ? IconButton(
              onPressed: () {
                // 引用付きの新規お知らせを作成
                context.go('/notice/register', extra: {'quotedNoticeUUID': noticeUuid, 'newNotice': true});
              },
              icon: const Icon(
                Icons.attach_file, // 右側のアイコン
                size: 30,
              ))
          : null,
      children: isLoading.value
          ? [const CircularProgressIndicator()]
          : [
              // なかみ
               NoticeDetailTab(tabData: noticeState.value, quotedNoticeData: quotedNoticeState.value), // 詳細

              Expanded(
                // リストビューは高さ制限を付けないと実行時エラーが出る
                child: readWidget.value,
              )
            ],
    );
  }
}
