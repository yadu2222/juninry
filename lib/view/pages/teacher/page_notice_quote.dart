import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/router/router.dart';
import 'package:juninry/view/components/molecule/notice_card.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '../../../constant/fonts.dart';
import '../../../models/notice_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート
import '../../../apis/service/notice_service.dart'; // 追加: NoticeServiceをインポート
import '../../components/atoms/add_button.dart';

class PageNoticeQuoteTeacher extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNoticeQuoteTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final notices = useState<List<Notice>>([]);
    final isLoading = useState(true);

    // お知らせ一覧取得関数
    Future<void> fetchNotices() async {
      try {
        // List<Notice> fetchedNotices = await NoticeService.getNotices();
        // notices.value = fetchedNotices;
        // print(fetchedNotices[0].className.toString());
      } catch (error) {
        debugPrint('Error fetching notices: $error');
      } finally {
        isLoading.value = false;
      }
    }

    useEffect(() {
      fetchNotices();
      return null;
    }, []);

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      // endDrawer: FilterDrawer(), // 追加: FilterDrawerの設定
      backgroundColor: AppColors.main, // HACK:背景色パワープレイ！！
      body: Stack(
        children: [
          BasicTemplate(
            title: '引用先を選択',
            popIcon: true,
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
        ],
      ),
    );
  }
}
