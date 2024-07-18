import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/class_dropdown.dart';
import 'package:juninry/view/components/molecule/long_text_field.dart';
import 'package:juninry/view/components/molecule/quote_from_notice.dart';
import '../../../constant/fonts.dart';

import 'package:intl/intl.dart';

//クラスのセレクトボックスに使うデータ型
import 'package:juninry/models/class_model.dart';

class CreateNoticeForm extends StatelessWidget {
  final List<Class> classesList; // クラス一覧
  final Class selectedClass; // 選択されているクラス
  final String userName; // 名前
  final String? quoteNoticeTitle; // 引用されているお知らせタイトル
  final void Function() onQuoteClicked; // 引用されているお知らせをクリックした時の処理

  final void Function(Class value) onClassChanged; // クラス選択時の処理
  final TextEditingController titleController; // タイトル
  final TextEditingController textController; // 本文

  const CreateNoticeForm({
    super.key,
    required this.classesList,
    required this.selectedClass,
    required this.userName,
    required this.quoteNoticeTitle,
    required this.onQuoteClicked,
    required this.onClassChanged,
    required this.titleController,
    required this.textController,
  });


  //初期化


  @override
  Widget build(BuildContext context) {
    //白い枠
    return ListItem(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 500,
        widget: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //日付とクラスのセレクトボックス
            Text(DateFormat('yyyy.MM.dd').format(DateTime.now()),
                style: Fonts.h4),
            ClassDropdown(
              selectedClass: selectedClass,
              items: classesList,
              onChanged: onClassChanged,
            )
          ]),

          //名前ブロック
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Text(userName, style: Fonts.p),
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
            controller:  titleController,
          ),

          //引用ブロック
          QuoteFromNotice(
            //引用するお知らせ
            quoteNoticeTitle: quoteNoticeTitle,
            onQuoteClicked: onQuoteClicked,
          ),

          // 入力ブロック
          Expanded(
            child: LongTextField(textController: textController),
          ),
        ]));
  }
}
