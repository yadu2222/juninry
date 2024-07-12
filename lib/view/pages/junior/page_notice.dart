import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/molecule/notice_card.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '../../../constant/fonts.dart';
import '../../../models/notice_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート
import '../../../apis/service/notice_service.dart'; // 追加: NoticeServiceをインポート

class PageNoticeJunior extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNoticeJunior({super.key});

  @override
  Widget build(BuildContext context) {
    final notices = useState<List<Notice>>([]);
    final isLoading = useState(true);

    useEffect(() {
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

      fetchNotices();
      return null;
    }, []);

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(), // 追加: FilterDrawerの設定
      backgroundColor: AppColors.main, // HACK:背景色パワープレイ！！
      body: BasicTemplate(
        title: 'おしらせ',
        popIcon: true,
        featureIconButton: IconButton(
          icon: Icon(Icons.sort, size: 35),
          onPressed: () {
            _scaffoldKey.currentState?.openEndDrawer(); // Drawerを開く
          },
        ),
        children: [
          isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Expanded(child: NoticeList(noticeDatas: notices.value)),
        ],
      ),
    );
  }
}
