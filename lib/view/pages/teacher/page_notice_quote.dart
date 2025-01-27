// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:juninry/constant/colors.dart';
// import 'package:go_router/go_router.dart';
// import 'package:juninry/router/router.dart';
// import 'package:juninry/view/components/molecule/notice_card.dart';
// import 'package:juninry/view/components/organism/notice_list.dart';
// import '../../../constant/fonts.dart';
// import '../../../models/notice_model.dart';
// import '../../components/template/basic_template.dart';
// import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート
// import '../../../apis/service/notice_service.dart'; // 追加: NoticeServiceをインポート
// import '../../components/atoms/add_button.dart';

// class PageNoticeQuoteTeacher extends HookWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   PageNoticeQuoteTeacher({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final notices = useState<List<Notice>>([]);
//     final isLoading = useState(true);

//     // お知らせ一覧取得関数
//     Future<void> fetchNotices() async {
//       try {
//         List<Notice> fetchedNotices = await NoticeService.getNotices();
//         notices.value = fetchedNotices;
//         print(fetchedNotices[0].className.toString());
//       } catch (error) {
//         debugPrint('Error fetching notices: $error');
//       } finally {
//         isLoading.value = false;
//       }
//     }

//     useEffect(() {
//       fetchNotices();
//       return null;
//     }, []);

//     return Scaffold(
//       key: _scaffoldKey, // 追加: Scaffold keyの設定
//       endDrawer: FilterDrawer(), // 追加: FilterDrawerの設定
//       backgroundColor: AppColors.main, // HACK:背景色パワープレイ！！
//       body: Stack(
//         children: [
//           BasicTemplate(
//             title: '引用先を選択',
//             popIcon: true,
//             featureIconButton: IconButton(
//               icon: const Icon(Icons.sort, size: 35),
//               onPressed: () {
//                 _scaffoldKey.currentState?.openEndDrawer(); // Drawerを開く
//               },
//             ),
//             children: [
//               isLoading.value
//                   ? const Center(child: CircularProgressIndicator())
//                   : Expanded(
//                       child: NoticeList(
//                       noticeDatas: notices.value,
//                       isTeacher: true,
//                       isQuote: true,
//                     )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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

class PageNoticeQuoteTeacher extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNoticeQuoteTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final noticeReq = NoticeReq(context: context); // 通信クラス
    final ClassReq classReq = ClassReq(context: context); // 通信クラス

    final notices = useState<List<Notice>>([]); // お知らせ一覧
    final isLoading = useState(true); // お知らせ一覧取得中
    final classList = useState<List<Class>>([]);

    final classListFilter = useState<List<String>>([]);

    // クラスリスト取得
    Future<void> getClassList() async {
      try {
        final result = await classReq.getClassesHandler();
        if (result == null) return;
        List<Class> fetchedClassList = result;
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
      } catch (error) {
        debugPrint('Error fetching notices: $error');
      } finally {
        isLoading.value = false;
      }
    }

    // お知らせ再取得
    Future<void> refreshNotices() async {
      List<String> queryClass = []; // クエリ用のクラスリスト
      if (classList.value.length != classListFilter.value.length) {
        //全選択時は送らない
        queryClass = List<String>.from(classListFilter.value);
      }
      isLoading.value = true;
      notices.value = await noticeReq.getNoticesHandler(classUUIDs: queryClass);
      isLoading.value = false;
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
      if (value) {
        classListFilter.value = List<String>.from(classList.value.map((e) => e.classUUID!));
      } else {
        classListFilter.value = [];
      }
    }

    useEffect(() {
      fetchNotices();
      getClassList();
      return null;
    }, []);

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(
        classList: classList.value, // 全クラス
        classListFilter: classListFilter.value,
        onClassListChanged: onClassListChanged,
        onAllClassListChanged: onAllClassListChanged,
        refreshNotices: refreshNotices,
      ), // 追加: FilterDrawerの設定
      backgroundColor: AppColors.main, // HACK:背景色パワープレイ！！
      body: BasicTemplate(
        title: '引用元',
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
              : Expanded(
                  child: NoticeList(
                  noticeDatas: notices.value,
                  isTeacher: true,
                  isQuote: true,
                )),
        ],
      ),
    );
  }
}
