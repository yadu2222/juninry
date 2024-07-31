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
import '../../../apis/service/notice_service.dart'; // 追加: NoticeServiceをインポート
import '../../components/atoms/add_button.dart';
import '../../../models/class_model.dart';
import '../../../apis/controller/class_req.dart';
import '../../../apis/controller/notice_req.dart';

import '../../components/molecule/no_resourcs.dart'; // からっぽ表示用のモジュール

class PageNotice extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final noticeReq = NoticeReq(context: context);
    final ClassReq classReq = ClassReq(context: context);

    final notices = useState<List<Notice>>([]);
    final isLoading = useState(true);
    final teacherExtension = useState(false); // 教師の場合に追加機能を表示するための変数
    final classList = useState<List<Class>>([]);
    final classListFilter = useState<List<Class>>([]);
    final readStatusFilter = useState<Map<(String, int), bool>>({
      ('確認済み', 1): true,
      ('未確認', 0): true,
    });

    // 追加ボタン押下時の処理
    void addPressed() {
      // 遷移処理
      context.go('/notice/register', extra: {'newNotice': true});
    }

    // お知らせ一覧取得関数
    Future<void> fetchNotices() async {
      try {
        List<Notice> fetchedNotices = await noticeReq.getNoticesHandler();
        notices.value = fetchedNotices;
        // HACK:既読絞り込みを実装するかをクソみたいな方法で実装
        // 既読状態が存在するならば、既読ソートの選択肢を生成
        if (fetchedNotices.first.readStatus != null) {
          readStatusFilter.value = {}; // 既読状態が存在しない場合は空のマップを生成
        }
      } catch (error) {
        debugPrint('Error fetching notices: $error');
      } finally {
        isLoading.value = false;
      }
    }

    // クラスリスト取得
    Future<void> getClassList() async {
      try {
        List<Class> fetchedClassList = await classReq.getClassesHandler();
        classList.value = fetchedClassList;
        classListFilter.value = List.from(fetchedClassList);
      } catch (error) {
        debugPrint('Error fetching class list: $error');
      }
    }

    // クラスフィルタリング
    void onClassListChanged(bool value, Class item) {
      if (classListFilter.value.contains(item)) {
        classListFilter.value.remove(item);
      } else {
        classListFilter.value.add(item);
      }
    }

    // お知らせ再取得
    Future<void> refreshNotices() async {
      int? readStatus;
      if (readStatusFilter.value.isNotEmpty) {
        // HACK:ヴァケモノ
        if (readStatusFilter.value.entries.first.value != readStatusFilter.value.entries.last.value) {
          if (readStatusFilter.value.entries.first.value) {
            readStatus = 1;
          } else {
            readStatus = 0;
          }
        }
      }
      List<String> classUUIDs = classListFilter.value.map((c) => c.classUUID!).toList();
      isLoading.value = true;
      notices.value = await noticeReq.getNoticesHandler(readStatus: readStatus, classUUIDs: classUUIDs);
      isLoading.value = false;
    }

    // ユーザータイプ取得関数
    Future<void> isTeacher() async {
      teacherExtension.value = await isBranch(BranchType.teacher);
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
        onClassListChanged: onClassListChanged,
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
            ...classListFilter.value.map((item) => Text(item.className)),
            // List<Widget>として渡す
            ...readStatusFilter.value.entries.map((item) => Text(
                item.key.$1.toString() +
                    item.key.$2.toString() +
                    '値' +
                    item.value.toString()))
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
