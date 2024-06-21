import '../models/homework_model.dart';
import '../models/notice_model.dart';
import '../models/student_model.dart';
import '../models/user_model.dart';
import '../models/teaching_item_model.dart';
import '../models/register_homework_model.dart';

// テスト用のさんぷるでーたの数がだいぶ増えてきたので、ここに書いておきます
// 最終的に消えるよ
class SampleData {
  static User juniorUser = User(
    userUUID: 'ほげおか',
    userName: 'junior',
    userTypeId: 0,
    mailAddress: '',
    password: 'password',
  );

  static User patronUser = User(
    userUUID: '',
    userName: 'patron',
    userTypeId: 1,
    mailAddress: '',
    password: 'password',
  );

  static User teacherUser = User(
    userUUID: '',
    userName: 'teacher',
    userTypeId: 2,
    mailAddress: '',
    password: 'password',
  );

  static User debugUser = User(
    userUUID: '',
    userName: 'debugUser',
    userTypeId: 3,
    mailAddress: '',
    password: 'password',
  );

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

  static List<RegisterHomework> registerHomeworkData = [
    RegisterHomework(teachingItem: teachingItem1),
    RegisterHomework(teachingItem: teachingItem2),
    RegisterHomework(teachingItem: teachingItem3),
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

  static List<Map> dueHomeworkData = [
    {'dueDate': DateTime.now().add(const Duration(days: 1)), 'homeworkData': homeworkData},
    {'dueDate': DateTime.now().add(const Duration(days: 2)), 'homeworkData': homeworkData},
  ];

  static List<Notice> noticesData = [
    Notice(
        noticeDate: '2024-6-3',
        className: '4-5',
        noticeTitle: 'お知らせがたくさん',
        noticeExplanatory:
            '少子化じゃなかったころおしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文おしらせ本文',
        noticeRead: '0'),
    Notice(noticeDate: '2024-6-2', noticeTitle: 'ほんのすこしのしんじつ', className: ';~~;', noticeExplanatory: '少子化じゃなかったころ', noticeRead: '1'),
    Notice(noticeDate: '2025.6.6', className: '3-A', noticeTitle: '夏休みの宿題について', noticeExplanatory: '最終日まで残さないように。\n二行目だよ。', noticeRead: '0')
  ];
}
