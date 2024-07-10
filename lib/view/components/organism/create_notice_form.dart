import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/class_dropdown.dart';
import 'package:juninry/view/components/molecule/long_text_field.dart';
import 'package:juninry/view/components/molecule/quote_from_notice.dart';
import '../../../constant/fonts.dart';
//日付を扱うためのライブラリ
import 'dart:core';
// 日付整形
import 'package:intl/intl.dart';
//クラスのセレクトボックスに使うデータ型
import 'package:juninry/models/class_model.dart';

class CreateNoticeForm extends StatefulWidget {
  final DateTime? dateTime;
  final List<Class> classesList; // クラス一覧
  final Class selectedClass; // 選択されているクラス
  final String userName; // 名前
  final String? quoteNoticeTitle; // 引用されているお知らせタイトル

  final void Function(Class value) onClassChanged; // クラス選択時の処理
  final TextEditingController titleController; // タイトル
  final TextEditingController textController; // 本文

  const CreateNoticeForm({
    super.key,
    this.dateTime,
    required this.classesList,
    required this.selectedClass,
    required this.userName,
    required this.quoteNoticeTitle,
    required this.onClassChanged,
    required this.titleController,
    required this.textController,
  });

  @override
  _CreateNoticeFormState createState() => _CreateNoticeFormState();
}

class _CreateNoticeFormState extends State<CreateNoticeForm> {
  //初期化
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //日付を取得
    final String date =
        DateFormat('yyyy.MM.dd').format(widget.dateTime ?? DateTime.now());

    //白い枠
    return ListItem(
        height: 500,
        widget: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //日付とクラスのセレクトボックス
            Text(date, style: Fonts.h4),
            ClassDropdown(
              selectedClass: widget.selectedClass,
              items: widget.classesList,
              onChanged: widget.onClassChanged,
            )
          ]),

          //名前ブロック
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Text(widget.userName ?? "", style: Fonts.p),
          ),

          //タイトルブロック
          TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "タイトル",
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.zero,
            ),
            style: Fonts.h3,
            controller: widget.titleController,
          ),

          //引用ブロック
          QuoteFromNotice(
            //引用するお知らせ
            quoteNoticeTitle: widget.quoteNoticeTitle,
          ),

          // 入力ブロック
          Expanded(
            child: LongTextField(textController: widget.textController),
          ),
        ]));
  }
}
