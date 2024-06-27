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

  static List<Map> patronHomeworkData2 = [
    {
      'juniorName': 'ほげた',
      'homeworkData': [
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
        )
      ]
    },
    {
      'juniorName': 'ほげみ',
      'homeworkData': [
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
        )
      ]
    }
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

  static List<Notice> noticesData = [
    Notice(noticeDate: '6.1', className: '2-B', noticeTitle: '保護者会のお知らせ', noticeExplanatory: '来週の月曜日に行います。', noticeRead: '1'),
  Notice(noticeDate: '6.4', className: '1-C', noticeTitle: '避難訓練の実施', noticeExplanatory: '6月10日に行います。', noticeRead: '0'),
  Notice(noticeDate: '6.5', className: '4-2', noticeTitle: '給食費について', noticeExplanatory: '今月の給食費の支払いをお願いします。', noticeRead: '1'),
  Notice(noticeDate: '6.7', className: '3-B', noticeTitle: '図書室の利用', noticeExplanatory: '図書室の利用時間が変更されました。', noticeRead: '0'),
  Notice(noticeDate: '6.8', className: '2-A', noticeTitle: '部活動の休止', noticeExplanatory: '今週の部活動は休止します。', noticeRead: '1'),
  Notice(noticeDate: '6.9', className: '1-A', noticeTitle: '遠足のお知らせ', noticeExplanatory: '6月15日に遠足があります。', noticeRead: '0'),
  Notice(noticeDate: '6.10', className: '4-3', noticeTitle: '学級会のお知らせ', noticeExplanatory: '学級会は明日行います。', noticeRead: '1'),
  Notice(noticeDate: '6.11', className: '3-C', noticeTitle: 'テスト週間のお知らせ', noticeExplanatory: '来週からテスト週間が始まります。', noticeRead: '0'),
  Notice(noticeDate: '6.12', className: '2-C', noticeTitle: '修学旅行の費用について', noticeExplanatory: '修学旅行の費用を確認してください。', noticeRead: '1'),
  Notice(noticeDate: '6.13', className: '1-B', noticeTitle: 'PTAからのお知らせ', noticeExplanatory: 'PTAの会合が来週あります。', noticeRead: '0')
  ];
}
