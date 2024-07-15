import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:go_router/go_router.dart';
import 'package:juninry/view/components/atoms/listItem_box.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import '../../../models/drafted_notice_model.dart';
import '../../components/template/basic_template.dart';

// 教員_課題一覧ページ
class PageNoticeDraftTeacher extends HookWidget {
  const PageNoticeDraftTeacher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final draftData = useState<List<DraftedNotice>>([]);

    // dbから下書きデータを取得
    Future<void> getDrafts() async {
      final data = await DraftedNotice.getAllDraftedNotices();
      draftData.value = data;
    }

    // useEffect内で非同期処理を実行するための方法
    useEffect(() {
      // 直接非同期関数を書くことはできない
      getDrafts(); // 非同期関数を呼び出し
    }, [draftData]);

    return BasicTemplate(title: "下書き", children: [
      ListItemBox(
        itemDatas: draftData.value,
        listItem: (draftedNoticeData) => InkWell(
          onTap: () {
            context.push('/notice/register',
                extra: {'draftedNoticeId': draftedNoticeData.draftedNoticeId});
            debugPrint(draftedNoticeData.draftedNoticeId.toString());
          },
          child: ListItem(
            widget: Text(draftedNoticeData.draftedNoticeTitle.toString()),
          ),
        ),
      ),
    ]);
  }
}
