import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/notice_req.dart';
import 'package:juninry/constant/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/router/router.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '../../../models/notice_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート
import '../../components/atoms/add_button.dart';
import '../../../models/class_model.dart';
import '../../../apis/controller/class_req.dart';

import '../../components/molecule/no_resourcs.dart'; // からっぽ表示用のモジュール

class PageNotice extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final noticeReq = NoticeReq(context: context); // 通信クラス
    final ClassReq classReq = ClassReq(context: context); // 通信クラス

    final notices = useState<List<Notice>>([]); // お知らせ一覧
    final isLoading = useState(true); // お知らせ一覧取得中
    final teacherExtension = useState(false); // 教師の場合に追加機能を表示するための変数
    final classList = useState<List<Class>>([]);

    final classListFilter = useState<List<String>>([]);
    final readFilterEnabled = useState(false); // 既読フィルターを表示するか否か
    final readStatusFilter =
        useState<Map<int, bool>>({0: true, 1: true}); // 既読フィルターの選択状態

    // 追加ボタン押下時の処理
    void addPressed() {
      // 遷移処理
      context.go('/notice/register', extra: {'newNotice': true});
    }

    // クラスリスト取得
    Future<void> getClassList() async {
      try {
        List<Class> fetchedClassList = await classReq.getClassesHandler();
        classList.value = fetchedClassList;
        fetchedClassList.forEach((element) {
          classListFilter.value.add(element.classUUID!);
        });
      } catch (error) {
        debugPrint('Error fetching class list: $error');
      }
    }

    // お知らせ一覧取得関数
    Future<void> fetchNotices() async {
      try {
        List<Notice> fetchedNotices = await noticeReq.getNoticesHandler();
        notices.value = fetchedNotices;
        // 既読状態が存在するならば、既読ソートの選択肢を生成
        // TODO: 分岐条件逆
        if (fetchedNotices.first.readStatus != null) {
          readFilterEnabled.value = true;
        }
      } catch (error) {
        debugPrint('Error fetching notices: $error');
      } finally {
        isLoading.value = false;
      }
    }

    // お知らせ再取得
    Future<void> refreshNotices() async {
      int? readStatus;
      if (readStatusFilter.value.isNotEmpty) {
        // HACK:ヴァケモノ
        if (readStatusFilter.value.entries.first.value !=
            readStatusFilter.value.entries.last.value) {
          if (readStatusFilter.value.entries.first.value) {
            readStatus = 1;
          } else {
            readStatus = 0;
          }
        }
      }
      List<String> queryClass = []; // クエリ用のクラスリスト
      if (classList.value.length != classListFilter.value.length) {
        //全選択時は送らない
        queryClass = List<String>.from(classListFilter.value);
      }
      isLoading.value = true;
      notices.value = await noticeReq.getNoticesHandler(
          readStatus: readStatus, classUUIDs: queryClass);
      isLoading.value = false;
    }

    // ユーザータイプ取得関数
    Future<void> isTeacher() async {
      teacherExtension.value = await isBranch(BranchType.teacher);
    }

    // クラスフィルタリング
    void onClassListChanged(bool value, Class item) {
      String classUUID = item.classUUID!;
      // useStateが描画更新しないので、現在のリストをコピーして変数に格納
      List<String> tempList = List<String>.from(classListFilter.value);
      if (classListFilter.value.contains(classUUID)) {
        tempList.remove(classUUID); // リストから削除
        classListFilter.value = tempList;
      } else {
        tempList.add(classUUID); // リストに追加
        classListFilter.value = tempList;
      }
    }

    void onAllClassListChanged(bool value) {
      debugPrint("押された? " + value.toString());
      if (value) {
        classListFilter.value = List<String>.from(classList.value.map((e) => e.classUUID!));
      } else {
        classListFilter.value = [];
      }
    }

    useEffect(() {
      isTeacher();
      fetchNotices();
      getClassList();
      return null;
    }, []);

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(
        classList: classList.value, // 全クラス
        classListFilter: classListFilter.value,
        readStatusFilter: readStatusFilter.value,
        readFilterEnabled: readFilterEnabled.value,
        onClassListChanged: onClassListChanged,
        onAllClassListChanged: onAllClassListChanged,
        refreshNotices: refreshNotices,
      ), // 追加: FilterDrawerの設定
      backgroundColor: AppColors.main, // HACK:背景色パワープレイ！！
      body: Stack(
        children: [
          BasicTemplate(
            title: 'おしらせ',
            popIcon: false,
            featureIconButton: IconButton(
              icon: const Icon(Icons.sort, size: 35),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer(); // Drawerを開く
              },
            ),
            children: [
              isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : notices.value.isEmpty
                      ? const NoResources()
                      : Expanded(
                          child: NoticeList(
                              noticeDatas: notices.value,
                              isTeacher: teacherExtension.value)),
            ],
          ),
          Column(children: [
            ...classListFilter.value.map((item) => Text(item.toString())),
            // List<Widget>として渡す
            ...readStatusFilter.value.entries.map((item) =>
                Text(item.key.toString() + '値' + item.value.toString()))
          ]),

          if (teacherExtension.value)
            Positioned(
                bottom: 25,
                right: 25,
                child: AddButton(onPressed: addPressed)), // 追加ボタン
        ],
      ),
    );
  }
}
