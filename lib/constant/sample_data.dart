import 'package:juninry/models/class_model.dart';

import '../models/homework_model.dart';
import '../models/notice_model.dart';
import '../models/drafted_notice_model.dart';
import '../models/student_model.dart';
import '../models/user_model.dart';
import '../models/teaching_item_model.dart';
// import '../models/register_homework_model.dart';
import '../models/quoted_notice_model.dart';

// テスト用のさんぷるでーたの数がだいぶ増えてきたので、ここに書いておきます
// 最終的に消えるよ
class SampleData {
  static String jwtKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjIwMzQ4MTQ0MTksImlkIjoiM2NhYzE2ODQtYzFlMC00N2FlLTkyZmQtNmQ3OTU5NzU5MjI0IiwianRpIjoiOGIzYTdjZGYtY2E1Ni00Y2EwLTlkODMtMDNjYjVkZWFhYmE4In0.fC63q6Igd6_yUDgi4RGiuQqpt02_hBC-PIeYRh5BgMM';
  static User teacherUser = User(
      userUUID: '9efeb117-1a34-4012-b57c-7f1a4033adb9',
      userName: 'teacher',
      userTypeId: 1,
      mailAddress: 'test-teacher@gmail.com',
      password: '\$2a\$10\$Ig/s1wsrXBuZ7qvjudr4CeQFhqJTLQpoAAp1LrBNh5jX9VZZxa3R6',
      jtiUUID: '42c28ac4-0ba4-4f81-8813-814dc92e2f40',
      jwtKey: jwtKey);
  static User juniorUser = User(
      userUUID: '5574bc10-c1f4-46e7-bbac-8503e03bab',
      userName: 'junior',
      userTypeId: 2,
      mailAddress: 'test-pupil@gmail.com',
      password: '\$2a\$10\$8hJGyU235UMV8NjkozB7aeHtgxh39wg/ocuRXW9jN2JDdO/MRz.fW',
      jtiUUID: '14dea318-8581-4cab-b233-995ce8e1a948',
      jwtKey: jwtKey);
  static User patronUser = User(userUUID: '', userName: 'patron', userTypeId: 3, mailAddress: '', password: 'password', jtiUUID: '14dea318-8581-4cab-b233-995ce8e1a948', jwtKey: jwtKey);

  static TeachingItem teachingItem1 = TeachingItem(
    teachingMaterialName: '漢字ドリル',
    subjectId: 0,
    teachingMaterialUuid: 'aaaaa',
  );

  static TeachingItem teachingItem2 = TeachingItem(
    teachingMaterialName: '計算ドリル',
    subjectId: 1,
    teachingMaterialUuid: 'aaaaa',
  );

  static TeachingItem teachingItem3 = TeachingItem(
    teachingMaterialName: '理科ワーク',
    subjectId: 2,
    teachingMaterialUuid: 'aaaaa',
  );

  static TeachingItem teachingItem4 = TeachingItem(
    teachingMaterialName: '社会に貢献しよう',
    subjectId: 3,
    teachingMaterialUuid: 'iiii',
  );

  static List<Homework> homeworkData = [
    Homework(
      homeworkUuid: 'aaaaa',
      homeworkLimit: DateTime.now().add(const Duration(days: 2)),
      startPage: 1,
      pageCount: 1,
      homeworkPosterUuid: 'aaaaa',
      homeworkNote: 'aaaaa',
      imageUuid: 'aaaaa',
      classUuid: 'aaaaa',
      submitFlg: 0,
      teachingItem: teachingItem1,
    ),
  ];

  // sampledata
  static List<TeachingItem> teachingItemData = [
    SampleData.teachingItem1,
    SampleData.teachingItem2,
    SampleData.teachingItem3,
  ];

  static List<Map> patronHomeworkData2 = [
    {
      'juniorName': 'ほげた',
      'homeworkData': [
        Homework(
          homeworkUuid: 'aaaaa',
          homeworkLimit: DateTime.now().add(const Duration(days: 1)),
          startPage: 1,
          pageCount: 1,
          homeworkPosterUuid: 'aaaaa',
          homeworkNote: 'aaaaa',
          imageUuid: 'aaaaa',
          classUuid: 'aaaaa',
          submitFlg: 0,
          teachingItem: teachingItem1,
        ),
      ]
    },
    {
      'juniorName': 'ほげみ',
      'homeworkData': [
        Homework(
            homeworkUuid: 'aaaaa',
            homeworkLimit: DateTime.now().add(const Duration(days: 1)),
            startPage: 1,
            pageCount: 1,
            homeworkPosterUuid: 'aaaaa',
            homeworkNote: 'aaaaa',
            imageUuid: 'aaaaa',
            classUuid: 'aaaaa',
            submitFlg: 0,
            teachingItem: teachingItem2),
      ]
    }
  ];

  // static List<RegisterHomework> registerHomeworkData = [
  //   RegisterHomework(teachingItem: teachingItem1),
  //   RegisterHomework(teachingItem: teachingItem2),
  //   RegisterHomework(teachingItem: teachingItem3),
  // ];

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

  static List<Map> dueHomeworkData = [
    {
      'dueDate': DateTime.now().add(const Duration(days: 1)),
      'homeworkData': homeworkData
    },
    {
      'dueDate': DateTime.now().add(const Duration(days: 2)),
      'homeworkData': homeworkData
    },
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

  static List<Class> classesData = [
    Class(
      classUuid: 'class0',
      className: '3-2 ふたば学級',
    ),
    Class(
      classUuid: 'class1',
      className: '3-5 みつば学級',
    ),
    Class(
      classUuid: 'class2',
      className: '4-2',
    ),
    Class(
      classUuid: 'class3',
      className: 'つよつよガンギマリ塾 1-A',
    ),
  ];

  static List<DraftedNotice> draftedNoticesData = [
    DraftedNotice(
      // 引用あり
      draftedNoticeTitle: '下書きをしたお知らせ',
      draftedNoticeExplanatory: '下書きのお知らせ本文',
      selectedClass: classesData[0],
      quotedNoticeUuid: 'quotedNotice0',
    ),
    // 下書きのみの場合
    DraftedNotice(
      draftedNoticeTitle: '引用なしドラゴン',
      draftedNoticeExplanatory: 'ド級の引用ド引用',
      selectedClass: classesData[2],
    ),
  ];

  static List<QuotedNotice> quotedNoticesData = [
    QuotedNotice(
      quotedNoticeUuid: 'quotedNotice0',
      quotedNoticeTitle: '引用したお知らせ',
      quotedClass: classesData[0],
    ),
    QuotedNotice(
      quotedNoticeUuid: 'quotedNotice1',
      quotedNoticeTitle: '引用したお知らせ2',
      quotedClass: classesData[1],
    ),
  ];
}
