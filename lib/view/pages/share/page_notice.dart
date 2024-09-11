import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/notice_req.dart';
import 'package:juninry/apis/controller/ouchi_req.dart';
import 'package:juninry/constant/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/models/notice_filters.dart';
import 'package:juninry/models/ouchi_model.dart';
import 'package:juninry/models/user_model.dart';
import 'package:juninry/router/router.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import 'package:path/path.dart';
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
    // API通信に使うクラスのインスタンスを生成
    final noticeReq = NoticeReq(context: context);
    final classReq = ClassReq(context: context);
    final ouchiReq = OUCHIReq(context);

    // お知らせ一覧の状態管理変数
    final notices = useState<List<Notice>>([]);

    // 通信中の状態管理変数
    final isLoading = useState(true);

    // 先生の場合にお知らせ作成ボタンを表示するための変数
    final teacherExtension = useState(false);
    // 先生は既読状態でフィルターしないため、分岐のための変数
    final readFilterEnabled = useState(false);

    // APIから取得したクラス一覧
    final classList = useState<List<Class>>([]);

    // APIから取得したおうちメンバー一覧
    final childrenList = useState<List<User>>([]);

    // 絞り込みで選択中のクラスUUID一覧
    final classListFilter = useState<List<String>>([]);

    // 絞り込みで選択中の子供UUID一覧
    final childrenListFilter = useState<List<String>>([]);

    // 絞り込みのモードがクラス一覧であるか
    final isClassFilterMode = useState<bool?>(null);

    // 既読フィルターの選択状態
    final readStatusFilter = useState<Map<int, bool>>({1: true, 0: true});

    // 追加ボタン押下時の処理
    void addPressed() {
      // 遷移処理
      context.go('/notice/register', extra: {'newNotice': true});
    }

    // フィルターに使うクラス一覧、お家メンバー一覧を取得
    Future<void> getNoticeFilters() async {
      // フィルターリストを取得
      try {
        // 親であれば子供のリストを取得してみて、2人以上いたら子供ソートを実装する
        if (await isBranch(BranchType.patron)) {
          // おうちのメンバーを取得する
          Ouchi ouchiData = await ouchiReq.getOuchiMembersHandler();

          // 子供であれば絞り込みの選択肢に追加し、選択済みにする
          for (User member in ouchiData.members!) {
            if (member.userTypeId == 2) {
              childrenList.value.add(member);
              childrenListFilter.value.add(member.userUUID!);
            }
          }

          if (childrenList.value.length > 1) {
            isClassFilterMode.value = true;
          }
        }

        // クラス一覧を取得する
        List<Class> fetchedClassList = await classReq.getClassesHandler();

        // クラス一覧に追加する
        classList.value = fetchedClassList;
        // 取得したクラスを選択済みリストに追加
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
        // 既読状態が存在するならば、既読フィルターを表示する
        if (fetchedNotices.isNotEmpty) {
          if (fetchedNotices.first.readStatus != null) {
            readFilterEnabled.value = true;
          }
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
            readStatus = readStatusFilter.value.entries.first.key;
          } else {
            readStatus = readStatusFilter.value.entries.last.key;
          }
        }
      }

      isLoading.value = true;
      // クラスと子供のどちらのフィルターを適用するか
      if (isClassFilterMode.value != false) {
        // 無効またはクラスフィルタリング

        List<String> queryFilter = [];
        if (classList.value.length != classListFilter.value.length) {
          //全選択されていないならばフィルターを適用する
          queryFilter = classListFilter.value;
        }
        // 再取得
        notices.value = await noticeReq.getNoticesHandler(
            readStatus: readStatus, classUUIDs: queryFilter);
      } else {
        List<String> queryFilter = [];
        if (childrenListFilter.value.length != childrenList.value.length) {
          //全選択されていないならばフィルターを適用する
          queryFilter = childrenListFilter.value;
        }
        notices.value = await noticeReq.getNoticesHandler(
            readStatus: readStatus, childrenUUIDs: queryFilter);
      }

      isLoading.value = false;
    }

    // ユーザータイプ取得関数
    Future<void> isTeacher() async {
      teacherExtension.value = await isBranch(BranchType.teacher);
    }

    void onFilterToggled(bool value) {
      isClassFilterMode.value = !value;
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

    // 子供フィルタリング
    void onChildrenListChanged(bool value, User item) {
      String userUUID = item.userUUID!;
      // useStateが描画更新しないので、現在のリストをコピーして変数に格納
      List<String> tempList = List<String>.from(childrenListFilter.value);
      if (childrenListFilter.value.contains(userUUID)) {
        tempList.remove(userUUID); // リストから削除
        childrenListFilter.value = tempList;
      } else {
        tempList.add(userUUID); // リストに追加
        childrenListFilter.value = tempList;
      }
    }

    // クラスの全選択、全解除
    void onAllClassListChanged(bool value) {
      if (value) {
        classListFilter.value =
            List<String>.from(classList.value.map((e) => e.classUUID!));
      } else {
        classListFilter.value = [];
      }
    }

    // 子供の全選択、全解除
    void onAllChildrenListChanged(bool value) {
      if (value) {
        childrenListFilter.value =
            List<String>.from(childrenList.value.map((e) => e.userUUID!));
      } else {
        childrenListFilter.value = [];
      }
    }

    useEffect(() {
      classListFilter.value = [];
      isTeacher();
      fetchNotices();
      // getNoticeFilters();
      return null;
    }, [_scaffoldKey]);

    useEffect(() {
      getNoticeFilters();
      return null;
    }, []);

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(
        classList: classList.value, // 全クラス
        classListFilter: classListFilter.value, // 選択済みクラス
        childrenList: childrenList.value, // 全子供
        childrenListFilter: childrenListFilter.value, // 選択済み子供
        isClassFilterMode: isClassFilterMode.value,
        readStatusFilter: readStatusFilter.value,
        readFilterEnabled: readFilterEnabled.value,
        onFilterToggled: onFilterToggled,
        onClassListChanged: onClassListChanged,
        onChildrenListChanged: onChildrenListChanged,
        onAllClassListChanged: onAllClassListChanged,
        onAllChildrenListChanged: onAllChildrenListChanged,
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

                          // スクロールで再取得
                          child: RefreshIndicator(
                              onRefresh: () async {
                                await fetchNotices();
                              },
                              child: NoticeList(
                                  noticeDatas: notices.value,
                                  isTeacher: teacherExtension.value))),
            ],
          ),

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
