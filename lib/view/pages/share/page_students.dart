import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:juninry/models/class_model.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/organism/student_List.dart';
// api
import '../../../apis/controller/class_req.dart';

class PageStudents extends HookWidget {
  const PageStudents({super.key});

  final String title = '生徒一覧';
  @override
  Widget build(BuildContext context) {
    ClassReq classReq = ClassReq(context: context); // 通信用クラスのインスタンスを生成
    final classmates = useState<List<dynamic>>([]); // 空で初期化
    final showClass = useState<List<bool>>([]); // クラス表示かどうか

    // 初回のみ実行
    // ここでapiからクラスメイトのリストを取得
    useEffect(() {
      // 非同期処理を実行するための関数
      Future<void> fetchData() async {
        debugPrint('クラスメイトを取得するよ');
        final data = await classReq.getClassmates();
        debugPrint(data.toString());
        classmates.value = data;
        showClass.value = List.filled(data.length, false); // クラス表示を初期化
      }
      fetchData(); // 非同期処理を実行
      return () {};
    }, []);

    void isShow(int index) {
      List<bool> updatedShowClass = List.from(showClass.value); // 状態をコピー
      updatedShowClass[index] = !updatedShowClass[index]; // クラス表示を反転
      showClass.value = updatedShowClass; // 状態を更新
    }

    return BasicTemplate(
      title: title, 
      popIcon: true,
      children: [
      // 教員もまとめて表示する？
      Expanded(child: StudentList.classes(studentData: classmates.value, isShow: isShow,isShowList:showClass.value))
    ]);
  }
}
