import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/custom_dropdown.dart';
import 'package:juninry/view/components/molecule/long_text_field.dart';
import 'package:juninry/view/components/molecule/quote_from_notice.dart';
import '../../../constant/fonts.dart';
//日付を扱えるクラスをインポート
import 'dart:core';
//クラスのセレクトボックスに使うデータ型
import 'package:juninry/models/classes.dart';
//intl
import 'package:intl/intl.dart';

class CreateNoticeForm extends StatefulWidget {
  final List<Classes> classesList;
  final void Function(Classes? value) onChanged;
  final Classes selectedClass;
  final String name;
  final void Function(String value) onTitleChanged;
  final String quoteNoticeTitle;
  final void Function(String value) onTextChanged;

  const CreateNoticeForm({
    super.key,
    required this.classesList,
    required this.onChanged,
    required this.selectedClass,
    required this.name,
    required this.onTitleChanged,
    this.quoteNoticeTitle = "投稿の引用",
    required this.onTextChanged,
  });

  @override
  _CreateNoticeFormState createState() => _CreateNoticeFormState();
}

class _CreateNoticeFormState extends State<CreateNoticeForm> {
  //クラスの選択項目
  late List<Classes> classesList;

  //名前
  late String name;

  //選択されているクラス
  late Classes selectedClass;

  //入力された内容
  late String noticeText;

  //初期化
  @override
  void initState() {
    super.initState();
    classesList = widget.classesList;
    selectedClass = widget.selectedClass;
    name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    //日付を取得
    final String date = DateFormat('yyyy.MM.dd').format(DateTime.now());

    //白い枠
    return ListItem(
        height: 500,
        widget: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //日付とクラスのセレクトボックス
            Text(date, style: Fonts.h4),
            ClassDropdown(
              selectedClass: selectedClass,
              items: classesList,
              onChanged: widget.onChanged,
            )
          ]),

          //名前ブロック
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Text(name, style: Fonts.p),
          ),

          //タイトルブロック
          TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "タイトル",
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: Fonts.h3,
            onChanged: widget.onTitleChanged,
          ),

          //引用ブロック
          QuoteFromNotice(
            //引用するお知らせ
            quoteNoticeTitle: widget.quoteNoticeTitle,
          ),

          // 入力ブロック
          Expanded(
            child: LongTextField(onTextChanged: widget.onTextChanged),
          ),
        ]));
  }
}
