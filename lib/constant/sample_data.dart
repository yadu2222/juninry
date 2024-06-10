import '../models/homework_model.dart';
import '../models/notice_model.dart';
import '../models/student_model.dart';

// テスト用のさんぷるでーたの数がだいぶ増えてきたので、ここに書いておきます
// 最終的に消えるよ
class SampleData {
  static List<Homework> homeworkData = [
    Homework(
      homeworkUuid: 'aaaaa',
      homeworkLimit: '2022/12/12',
      teachingMaterialUuid: 'aaaaa',
      startPage: 1,
      pageCount: 1,
      homeworkPosterUuid: 'aaaaa',
      homeworkNote: 'aaaaa',
      teachingMaterialName: '漢字ドリル',
      subjectId: 0,
      imageUuid: 'aaaaa',
      classUuid: 'aaaaa',
      submitFlg: 0,
    ),
    Homework(
      homeworkUuid: 'aaaaa',
      homeworkLimit: '2022/12/22',
      teachingMaterialUuid: 'aaaaa',
      startPage: 1,
      pageCount: 5,
      homeworkPosterUuid: 'aaaaa',
      homeworkNote: 'aaaaa',
      teachingMaterialName: '計算ドリル',
      subjectId: 1,
      imageUuid: 'aaaaa',
      classUuid: 'aaaaa',
      submitFlg: 1,
    ),
    Homework(
      homeworkUuid: 'aaaaa',
      homeworkLimit: '2022/12/22',
      teachingMaterialUuid: 'aaaaa',
      startPage: 1,
      pageCount: 5,
      homeworkPosterUuid: 'aaaaa',
      homeworkNote: 'aaaaa',
      teachingMaterialName: '理科ワーク',
      subjectId: 2,
      imageUuid: 'aaaaa',
      classUuid: 'aaaaa',
      submitFlg: 1,
    ),
  ];

  static List<Student> studentData = [
    Student(
      name: '山田太郎',
      num: 34,
      gender: '男',
    ),
    Student(
      name: '山田花子',
      num: 35,
      gender: '女',
    )
  ];

  static List<Notice> noticeData = [Notice(noticeTitle: 'お知らせがたくさん', noticeDate: '2024-6-3', noticeRead: '0'), Notice(noticeTitle: 'ほんのすこしのしんじつ', noticeDate: '2024-6-2', noticeRead: '1')];
}
