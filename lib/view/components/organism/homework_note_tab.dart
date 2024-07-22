import 'package:flutter/material.dart';
import 'package:juninry/view/components/molecule/class_dropdown.dart';

import '../../components/atoms/listitem.dart';
import '../../../constant/fonts.dart';
import 'package:intl/intl.dart';
import '../../../models/class_model.dart';

class HomeworkNoteTab extends StatelessWidget {
  const HomeworkNoteTab({
    super.key,
    required this.selectDate,
    required this.date,
    required this.selectClass,
    required this.classList,
    required this.onChanged,
  });

  final void Function() selectDate;
  final String? date;
  final Class selectClass;
  final List<Class> classList;
  final void Function(Class) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListItem(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        widget: Column(children: [
          // // ここに課題登録フォームを追加
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //日付とクラスのセレクトボックス
            Row(children: [
              IconButton(
                  onPressed: () {
                    selectDate();
                  },
                  icon: const Icon(Icons.calendar_today)),
              Text(DateFormat('yyyy.MM.dd').format(DateTime.parse(date ?? DateTime.now().toString())), style: Fonts.h4)
            ]),
            ClassDropdown(
              selectedClass: selectClass,
              items: classList,
              onChanged: onChanged,
            )
          ]),
        ]));
  }
}
