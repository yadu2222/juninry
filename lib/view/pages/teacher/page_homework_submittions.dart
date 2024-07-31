import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// view
import '../../components/molecule/homework_card.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/student_list.dart';
import '../../components/template/basic_template.dart';
// model
import '../../../models/homework_model.dart';
import '../../../models/student_model.dart';
// api
// import '../../../apis/controller/homework_req.dart';
// sample
import '../../../constant/sample_data.dart';

// 提出ページ
class PageSubmissionsTeacher extends HookWidget {
  final String homeworkUUID;
  const PageSubmissionsTeacher({
    super.key,
    required this.homeworkUUID,
  });

  final String title = '提出状況';

  @override
  Widget build(BuildContext context) {
    // final HomeworkReq homeworkReq = HomeworkReq(context: context); // APIコントローラー 現在の閲覧している宿題を取得
    final homeworkData = useState<Homework>(SampleData.homeworkData[0]); // 宿題データ
    final studentData = useState<List<Student>>(SampleData.studentData); // 提出者データ

    // 生徒カード押下時の処理
    void moveSubmissionDetail(Student student) {
      // 提出者の詳細ページへ遷移
      context.go('/homework/submittions/detail', extra: {'studentUUID': student.studentUUID, 'homeworkUUID': homeworkData.value.homeworkUUID});
    }

    Future<void> getSubmittionData() async {}

    // 初回起動時に実行
    useEffect(() {
      // TODO:homework!!!!!!!!!!!!!!!!取得!!!!!!!!!!!!!!!!!!!!!!!!!
      // TODO: ここで課題IDを元に提出済の人間たちを取得
      getSubmittionData();

      return () {};
    }, []);

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      HomeworkCard.teacher(homeworkData: homeworkData.value), // 課題カード
      const DividerView(), // 区切り線
      // 提出した人たちのリスト
      Expanded(
          child: RefreshIndicator(
              onRefresh: () async {
                await getSubmittionData();
              },
              child: StudentList(
                studentData: studentData.value,
                onTap: moveSubmissionDetail,
              ))), // 提出リスト
    ]);
  }
}
