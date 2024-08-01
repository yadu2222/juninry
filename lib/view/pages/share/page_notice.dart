import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/router/router.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '../../../models/notice_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート
import '../../../apis/service/notice_service.dart'; // 追加: NoticeServiceをインポート
import '../../components/atoms/add_button.dart';

import '../../components/molecule/no_resourcs.dart'; // からっぽ表示用のモジュール

class PageNotice extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final notices = useState<List<Notice>>([]);
    final isLoading = useState(true);
    final teacherExtension = useState(false); // 教師の場合に追加機能を表示するための変数

    // 追加ボタン押下時の処理
    void addPressed() {
      // 遷移処理
      context.go('/notice/register');
    }

    // お知らせ一覧取得関数
    Future<void> fetchNotices() async {
      try {
        List<Notice> fetchedNotices = await NoticeService.getNotices();
        notices.value = fetchedNotices;
      } catch (error) {
        debugPrint('Error fetching notices: $error');
      } finally {
        isLoading.value = false;
      }
    }

    // ユーザータイプ取得関数
    Future<void> isTeacher() async {
      teacherExtension.value = await isBranch(BranchType.teacher);
    }

    useEffect(() {
      isTeacher();
      fetchNotices();
      return null;
    }, [_scaffoldKey]);

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(), // 追加: FilterDrawerの設定
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
                              child: NoticeList(noticeDatas: notices.value, isTeacher: teacherExtension.value))),
            ],
          ),
          if (teacherExtension.value) Positioned(bottom: 25, right: 25, child: AddButton(onPressed: addPressed)), // 追加ボタン
        ],
      ),
    );
  }
}
