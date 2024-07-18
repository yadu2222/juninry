import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:go_router/go_router.dart';
import '../../../models/drafted_notice_model.dart';
import '../../components/atoms/listItem_box.dart';
import '../../components/molecule/draft_card.dart';
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

    // 下書き削除
    void delete(int draftedNoticeId) async {
      await DraftedNotice.deleteDraftedNotice(draftedNoticeId);
      await getDrafts();
    }

    // タップした時の遷移先
    void onTap(int draftedNoticeId) {
      context.push('/notice/register',
          extra: {'draftedNoticeId': draftedNoticeId});
    }

    // useEffect内で非同期処理を実行するための方法
    useEffect(() {
      // 直接非同期関数を書くことはできない
      getDrafts(); // 非同期関数を呼び出し
    }, []);

    return BasicTemplate(title: "下書き", children: [
      ListItemBox(
        itemDatas: draftData.value,
        listItem: (draftedNoticeData) =>
            DraftCard(
              onTap: () {
                onTap(draftedNoticeData.draftedNoticeId!);
              },
              delete: () {
                delete(draftedNoticeData.draftedNoticeId!);
              },
              date: draftedNoticeData.draftedNoticeDate!.substring(5),
              widget: Text(draftedNoticeData.draftedNoticeTitle.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
        ),

    ]);
  }
}
