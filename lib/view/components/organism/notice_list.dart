import 'package:flutter/material.dart';

import '../molecule/notice_card.dart';
import '../atoms/listItem_box.dart';
//LISTの型指定のためのファイル
import '../../../models/notice_model.dart';

// お知らせリストのステートフルウィジェット
class NoticeList extends StatefulWidget {
  //noticeDatasのListの型をnotice_nodel.dartから持ってくる
  final List<Notice> noticeDatas;
  const NoticeList({super.key,required this.noticeDatas});

  // ウィジェットの状態を作成する
  @override
  _NoticeListState createState() => _NoticeListState();
}

// _NoticeListState は NoticeList の状態を管理するクラス
class _NoticeListState extends State<NoticeList> {

  // ビルドメソッドはウィジェットツリーを構築する
  @override
  Widget build(BuildContext context) {
    // 現在は空のコンテナを返している
    return InkWell(
          onTap: () {
          // 画面遷移
          // context.push('/sample');
        },
        child: ListItemBox<Notice>(
          itemDatas: widget.noticeDatas,
          listItem:
          (notice) => NoticeCard(noticeData: notice),
        ));

  }
}
