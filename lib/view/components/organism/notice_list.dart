import 'package:flutter/material.dart';

import '../molecule/notice_card.dart';
import '../atoms/listItem_box.dart';
//LISTの型指定のためのファイル
import '../../../models/notice_model.dart';


// お知らせリストのステートフルウィジェット
class NoticeList extends StatelessWidget {
  //noticeDatasのListの型をnotice_nodel.dartから持ってくる
  final List<Notice> noticeDatas;
  final bool isQuote;
  final bool isTeacher;

  const NoticeList({super.key, required this.noticeDatas, this.isQuote = false, this.isTeacher = false});

  // ウィジェットの状態を作成する

  // ビルドメソッドはウィジェットツリーを構築する
  @override
  Widget build(BuildContext context) {
    // 現在は空のコンテナを返している
    return ListItemBox<Notice>(
      itemDatas: noticeDatas,
      listItem: (notice) => NoticeCard(noticeData: notice, isQuote: isQuote, isTeacher: isTeacher),
    );
  }
}
