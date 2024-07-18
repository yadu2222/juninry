import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../constant/sample_data.dart';
import '../../components/organism/notice_list.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート

class PageNoticeJunior extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNoticeJunior({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(), // 追加: FilterDrawerの設定
      backgroundColor: AppColors.main,//HACK:背景色パワープレイ！！
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
          Expanded(child: NoticeList(noticeDatas: SampleData.noticesData)),
        ],
      ),
    );
  }
}
