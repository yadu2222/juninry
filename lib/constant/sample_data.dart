import 'package:juninry/models/class_model.dart';
import '../models/homework_model.dart';
import '../models/notice_model.dart';
import '../models/drafted_notice_model.dart';
import '../models/student_model.dart';
import '../models/user_model.dart';
import '../models/teaching_item_model.dart';
import '../models/help_model.dart';
import '../models/reward_model.dart';
// import '../models/register_homework_model.dart';
import '../models/quoted_notice_model.dart';

// テスト用のさんぷるでーたの数がだいぶ増えてきたので、ここに書いておきます
// 最終的に消えるよ
class SampleData {
  static String jwtKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjIwMzQ4MTkxMTgsImlkIjoiM2NhYzE2ODQtYzFlMC00N2FlLTkyZmQtNmQ3OTU5NzU5MjI0IiwianRpIjoiY2ExYmY2MGItMzlmNS00NTI5LWE5YzEtYzJlNjQzYzEyNDBiIn0.x-3FXjbiOVRbkg05-sPvIShSC86jvvsBWudDrsJjO-I';
  static User teacherUser =
      User(userName: 'teacher', userTypeId: 1, mailAddress: 'test-teacher@gmail.com', password: '\$2a\$10\$Ig/s1wsrXBuZ7qvjudr4CeQFhqJTLQpoAAp1LrBNh5jX9VZZxa3R6', jwtKey: jwtKey);
  static User juniorUser = User(userName: 'junior', userTypeId: 2, mailAddress: 'test-pupil@gmail.com', password: '\$2a\$10\$8hJGyU235UMV8NjkozB7aeHtgxh39wg/ocuRXW9jN2JDdO/MRz.fW', jwtKey: jwtKey);
  static User patronUser = User(userName: 'patron', userTypeId: 3, mailAddress: '', password: 'password', jwtKey: jwtKey);

  static TeachingItem teachingItem1 = TeachingItem(
    teachingMaterialName: '漢字ドリル',
    subjectId: 1,
    teachingMaterialUUID: '978f9835-5a16-4ac0-8581-7af8fac06b4e',
  );

  static TeachingItem teachingItem2 = TeachingItem(
    teachingMaterialName: '計算ドリル',
    subjectId: 2,
    teachingMaterialUUID: '978f9835-5a16-4ac0-8581-7affac06b4e',
  );

  static TeachingItem teachingItem3 = TeachingItem(
    teachingMaterialName: '理科ワーク',
    subjectId: 3,
    teachingMaterialUUID: '978f9835-5a16-4ac0-8581-7af8fac0b4e',
  );

  static TeachingItem teachingItem4 = TeachingItem(
    teachingMaterialName: '社会に貢献しよう',
    subjectId: 4,
    teachingMaterialUUID: 'iiii',
  );

  static List<Homework> homeworkData = [
    Homework(
      homeworkUUID: 'aaaaa',
      homeworkLimit: DateTime.now().add(const Duration(days: 2)),
      startPage: 1,
      pageCount: 1,
      homeworkPosterUuid: 'aaaaa',
      homeworkNote: 'aaaaa',
      imageUuid: 'aaaaa',
      className: 'aaaaa',
      submitFlg: 0,
      teachingItem: teachingItem1,
    ),
    Homework(
      homeworkUUID: 'aaaaa',
      homeworkLimit: DateTime.now().add(const Duration(days: 2)),
      startPage: 3,
      pageCount: 12,
      homeworkPosterUuid: 'aaaaa',
      homeworkNote: 'aaaaa',
      imageUuid: 'aaaaa',
      className: 'aaaaa',
      submitFlg: 0,
      teachingItem: teachingItem1,
    ),
  ];

  static List<dynamic> apiHomeworkData = [
    {
      'className': 'あおば学級',
      'homeworkData': [
        Homework(
          homeworkUUID: 'aaaaa',
          homeworkLimit: DateTime.now().add(const Duration(days: 2)),
          startPage: 1,
          pageCount: 1,
          homeworkPosterUuid: 'aaaaa',
          homeworkNote: 'aaaaa',
          imageUuid: 'aaaaa',
          className: 'aaaaa',
          submitFlg: 0,
          teachingItem: teachingItem1,
        ),
        Homework(
          homeworkUUID: 'aaaaa',
          homeworkLimit: DateTime.now().add(const Duration(days: 2)),
          startPage: 1,
          pageCount: 1,
          homeworkPosterUuid: 'aaaaa',
          homeworkNote: 'aaaaa',
          imageUuid: 'aaaaa',
          className: 'aaaaa',
          submitFlg: 0,
          teachingItem: teachingItem2,
        ),
      ]
    }
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
          homeworkUUID: 'aaaaa',
          homeworkLimit: DateTime.now().add(const Duration(days: 1)),
          startPage: 1,
          pageCount: 1,
          homeworkPosterUuid: 'aaaaa',
          homeworkNote: 'aaaaa',
          imageUuid: 'aaaaa',
          className: 'aaaaa',
          submitFlg: 0,
          teachingItem: teachingItem1,
        ),
      ]
    },
    {
      'juniorName': 'ほげみ',
      'homeworkData': [
        Homework(
            homeworkUUID: 'aaaaa',
            homeworkLimit: DateTime.now().add(const Duration(days: 1)),
            startPage: 1,
            pageCount: 1,
            homeworkPosterUuid: 'aaaaa',
            homeworkNote: 'aaaaa',
            imageUuid: 'aaaaa',
            className: 'aaaaa',
            submitFlg: 0,
            teachingItem: teachingItem2),
      ]
    }
  ];

  static List<Help> helpData = [
    Help(helpTitle: 'せんたくもの', helpContent: 'たたむところまでおねがいね', iconId: 2, rewardPoint: 30, isReword: true),
    Help(helpTitle: 'せんたくもの', helpContent: 'たたむところまでおねがいね', iconId: 2, rewardPoint: 30, isReword: true),
    Help(helpTitle: 'せんたくもの', helpContent: 'たたむところまでおねがいね', iconId: 2, rewardPoint: 30, isReword: true),
    Help(helpTitle: 'せんたくもの', helpContent: 'たたむところまでおねがいね', iconId: 2, rewardPoint: 30, isReword: false),
    Help(helpTitle: 'せんたくもの', helpContent: 'たたむところまでおねがいね', iconId: 2, rewardPoint: 30, isReword: true),
    Help(helpTitle: 'せんたくもの', helpContent: 'たたむところまでおねがいね', iconId: 2, rewardPoint: 30, isReword: false),
  ];

  static List<Reward> rewardData = [
    Reward(rewardName: 'アイス', note: '150円まで', rewardPoint: 50, iconId: 1),
    Reward(rewardName: '晩ごはん指名権', note: '予算1000円', rewardPoint: 10, iconId: 3, stock: 5),
  ];

  // static List<RegisterHomework> registerHomeworkData = [
  //   RegisterHomework(teachingItem: teachingItem1),
  //   RegisterHomework(teachingItem: teachingItem2),
  //   RegisterHomework(teachingItem: teachingItem3),
  // ];

  static List<Student> studentData = [
    Student(
      studentUUID: 'aaa',
      name: '山田太郎',
      num: 34,
      gender: 1,
    ),
    Student(
      studentUUID: 'bbb',
      name: '山田花子',
      num: 35,
      gender: 2,
    )
  ];

  static List<Map> dueHomeworkData = [
    {'homeworkLimit': DateTime.now().add(const Duration(days: 1)), 'homeworkData': homeworkData},
    {'homeworkLimit': DateTime.now().add(const Duration(days: 2)), 'homeworkData': homeworkData},
  ];

  static List<Notice> noticesData = [
    Notice(noticeUUID: 'aaaaa', noticeDate: '2024-6-3', className: '4-5', classUUID: '12345', noticeTitle: '【持ち物】お弁当', noticeExplanatory: '明日の遠足ではお弁当がいります。忘れずに持ってきてください', readStatus: 0),
    Notice(noticeUUID: 'aaaaa', classUUID: '', noticeDate: '2024-6-2', noticeTitle: 'ほんのすこしのしんじつ', className: ';~~;', readStatus: 1),
    Notice(
      noticeUUID: 'aaaaa',
      classUUID: '',
      noticeDate: '2025.6.6',
      className: '3-A',
      noticeTitle: '夏休みの宿題について',
      readStatus: 0,
      noticeExplanatory:
          '少子化じゃなかったころおしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文',
    ),
    Notice(noticeDate: '2024-6-2', noticeTitle: 'ほんのすこしのしんじつ', classUUID: '12345', className: ';~~;', noticeExplanatory: '少子化じゃなかったころ', readStatus: 0),
    Notice(noticeDate: '2025.6.6', className: '3-A', classUUID: '12345', noticeTitle: '夏休みの宿題について', noticeExplanatory: '最終日まで残さないように。\n二行目だよ。', readStatus: 0)
  ];

  static List<DraftedNotice> draftedNoticesData = [
    DraftedNotice(
      // 引用あり
      draftedNoticeId: 2,
      draftedNoticeTitle: '下書きをしたお知らせ',
      draftedNoticeExplanatory: '下書きのお知らせ本文',
      selectedClass: classList[0],
      quotedNoticeUuid: '51e6807b-9528-4a4b-bbe2-d59e9118a70d',
    ),
    // 下書きのみの場合
    DraftedNotice(
      draftedNoticeId: 1,
      draftedNoticeTitle: '引用なしドラゴン',
      draftedNoticeExplanatory: 'ド級の引用ド引用',
      selectedClass: classList[2],
    ),
  ];

  static List<QuotedNotice> quotedNoticesData = [
    QuotedNotice(
      quotedNoticeUuid: 'quotedNotice0',
      quotedNoticeTitle: '引用したお知らせ',
      quotedClass: classList[0],
    ),
    QuotedNotice(
      quotedNoticeUuid: 'quotedNotice1',
      quotedNoticeTitle: '引用したお知らせ2',
      quotedClass: classList[1],
    ),
  ];

  static List<Class> classList = [
    Class(
      classUUID: '09eba495-fe09-4f54-a856-9bea9536b661',
      className: '3-2 ふたば学級',
    ),
    Class(
      classUUID: '817f600e-3109-47d7-ad8c-18b9d7dbdf8b',
      className: 'sample2',
    ),
    Class(
      classUUID: '456789',
      className: 'sample3',
    ),
  ];
}
