import 'package:juninry/models/classes.dart';

import '../models/homework_model.dart';
import '../models/notice_model.dart';
import '../models/student_model.dart';
import '../models/user_model.dart';

// テスト用のさんぷるでーたの数がだいぶ増えてきたので、ここに書いておきます
// 最終的に消えるよ
class SampleData {
  static User user = User(
    userUUID: '',
    userName: 'ほげた',
    userTypeId: 1,
    mailAddress: '',
    password: 'password',
  );

  static User user2 = User(
    userUUID: '',
    userName: 'debugUser',
    userTypeId: 3,
    mailAddress: '',
    password: 'password',
  );

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
    Notice(
        noticeDate: '2024-6-3',
        className: '4-5',
        noticeTitle: 'お知らせがたくさん',
        noticeExplanatory:
            '少子化じゃなかったころおしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文',
        noticeRead: '0'),
    Notice(
        noticeDate: '2024-6-2',
        noticeTitle: 'ほんのすこしのしんじつ',
        className: ';~~;',
        noticeExplanatory: '少子化じゃなかったころ',
        noticeRead: '1'),
    Notice(
        noticeDate: '2025.6.6',
        className: '3-A',
        noticeTitle: '夏休みの宿題について',
        noticeExplanatory: '最終日まで残さないように。\n二行目だよ。',
        noticeRead: '0')
  ];

  static List<Classes> classesData = [
    Classes(
      classUuid: 'aaaaa',
      className: '3-2 ふたば学級',
    ),
    Classes(
      classUuid: 'aaaaa',
      className: '3-5 みつば学級',
    ),
    Classes(
      classUuid: 'aaaaa',
      className: '4-2',
    ),
    Classes(
      classUuid: 'aaaaa',
      className: 'つよつよガンギマリ塾 1-A',
    ),
  ];
}
