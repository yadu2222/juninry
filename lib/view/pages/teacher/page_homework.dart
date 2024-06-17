import 'package:flutter/material.dart';

import '../../../models/homework_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/due_homework_list.dart';

import '../../components/atoms/add_button.dart';

import '../../../constant/sample_data.dart'; // sampleData

// 教員_課題一覧ページ
class PageHomeworkTeacher extends StatefulWidget {
  final String classUUID; // クラスIDをもとに取得？
  const PageHomeworkTeacher({super.key, required this.classUUID});

  @override
  PageHomeworkTeacherState createState() => PageHomeworkTeacherState();
}

class PageHomeworkTeacherState extends State<PageHomeworkTeacher> {
  final String title = '宿題一覧'; // appbarのタイトル
  // 区切り線のプロパティ
  final IconData icon = Icons.menu_book_outlined;
  final String divideTitle = 'test';
  late List<Homework> homeworkData;

  // 追加ボタン押下時の処理
  void addPressed() {
    // 遷移処理
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ここで取得処理
    homeworkData = SampleData.homeworkData; // 現在はサンプルデータを使用
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BasicTemplate(title: title, children: [
        // newExoandedでラップするとサイズを自動調整してくれるようになる
        // べんり〜〜！！！
        Expanded(
            child: DueHomeworkList(
          homeworkData: SampleData.dueHomeworkData,
        )),
      ]),
      Positioned(bottom: 35, right: 30, child: AddButton(onPressed: addPressed)), // 追加ボタン
    ]);
  }
}
