import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';
import '../../components/molecule/divider.dart';
import '../../components/template/basic_template.dart';
// import '../../components/atoms/student_view.dart';
// model
import '../../../models/homework_model.dart';
// import '../../../models/student_model.dart';
// api
// import '../../../apis/controller/homework_req.dart';
// image
import 'dart:io'; // ファイル操作用ライブラリ
// sample
import '../../../constant/sample_data.dart';

class PageHomeworkDetail extends HookWidget {
  final String studentUUID;
  final String homeworkUUID;
  const PageHomeworkDetail({super.key, required this.studentUUID, required this.homeworkUUID});

  final String title = '提出物';
  @override
  Widget build(BuildContext context) {
    // final HomeworkReq homeworkReq = HomeworkReq(context: context); // APIコントローラー
    final homework = useState<Homework>(SampleData.homeworkData[1]); // 課題データ
    // final student = useState<Student>(SampleData.studentData[0]); // 課題データ
    final images = useState<List<File?>>([]); // 画像配列 空で初期化

    // 初回起動時に実行
    useEffect(() {
      // TODO:homework!!!!!!!!!!!!!!!!取得!!!!!!!!!!!!!!!!!!!!!!!!!
      // TODO: ここで課題IDと生徒IDを元に提出物たちを取得
      Future<void> fetchData() async {}
      fetchData();
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      HomeworkCard.teacher(homeworkData: SampleData.homeworkData[0]), // 課題カード
      // TODO:ここに生徒の情報
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ...StudentView.getChildren(student.value),
      //   ],
      // ),

      const DividerView(), // 区切り線
      // 提出リスト
      Expanded(
          child: SubmittionList(
        homeworkData: homework.value,
        images: images.value,
      )), // 提出リスト
    ]);
  }
}
