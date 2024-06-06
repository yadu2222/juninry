import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../molecule/student_card.dart';
import '../atoms/listItem_box.dart';

// お知らせリストのステートフルウィジェット
class NoticeList extends StatefulWidget {
  const NoticeList({Key? key}) : super(key: key);

  // ウィジェットの状態を作成する
  @override
  _NoticeListState createState() => _NoticeListState();
}

// _NoticeListState は NoticeList の状態を管理するクラス
class _NoticeListState extends State<NoticeList> {
  

  final List<Map<String, String>> sumpleData = [
    {
      'name': '山田太郎',
      'num': '34',
      'gender': '男',
    },
    {
      'name': '山田花子',
      'num': '35',
      'gender': '女',
    },
  ];
  // ビルドメソッドはウィジェットツリーを構築する
  @override
  Widget build(BuildContext context) {
    // 現在は空のコンテナを返している
    return InkWell(
          onTap: () {
          // 画面遷移
          context.push('/sample');
        },
        child: ListItemBox(
          itemDatas: sumpleData,
          listItem: 
          
          (map) => StudentCard(studentData: map),
        ));
  }
}
