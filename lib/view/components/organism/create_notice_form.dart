import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/molecule/class_dropdown_button.dart';
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

  const CreateNoticeForm({super.key, required this.classesList,required this.onChanged, required this.selectedClass});
  @override
  _CreateNoticeFormState createState() => _CreateNoticeFormState();
}

class _CreateNoticeFormState extends State<CreateNoticeForm> {
  //クラスの選択項目
  late List<Classes> classesList;
  //選択されているクラス
  late Classes selectedClass;

  //初期化
  @override
  void initState() {
    super.initState();
    classesList = widget.classesList;
    selectedClass = widget.selectedClass;
  }

  @override
  Widget build(BuildContext context) {
    //日付を取得
    final String date = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return ListItem(
        //白い枠のある箱の中にある
        widget: Column(//基本的に縦並びで表示する
            children: [
      Row(children: [
        Text(date, style: Fonts.h4),
        ClassDropdownButton(
          selectedClass: selectedClass,
          classesList: classesList,
          onChanged: widget.onChanged,
        ),
      ]),
    ]));
  }
}
