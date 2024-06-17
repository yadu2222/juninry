import 'package:flutter/material.dart';
import 'package:juninry/constant/sample_data.dart';
import '../../components/template/scroll_template.dart';
// import '../../components/organism/homework_register_form.dart';
import '../../components/organism/homework_register_tab.dart';
import '../../../models/teaching_item_model.dart';

class PageHomeworkRegisterTeacher extends StatefulWidget {
  const PageHomeworkRegisterTeacher({super.key});

  @override
  _PageHomeworkRegisterTeacherState createState() => _PageHomeworkRegisterTeacherState();
}

class _PageHomeworkRegisterTeacherState extends State<PageHomeworkRegisterTeacher> {




  @override
  Widget build(BuildContext context) {
    return ScrollTemplate(title: '課題登録', children: [
      // ここに課題登録フォームを追加
      HomeworkRegisterTab(teachingItemData: SampleData.teachingItemData),
    ]);
  }
}
