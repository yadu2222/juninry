import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/molecule/notice_card.dart';
import 'package:juninry/view/components/organism/notice_list.dart';
import '../../../constant/fonts.dart';
import '../../../constant/sample_data.dart';
import '../../components/template/basic_template.dart';
import '../../components/organism/notice_filter.dart'; // 追加: notice_filter.dartをインポート
import '../../components/atoms/add_button.dart';

class PageNoticeTeacher extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageNoticeTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    // 追加ボタン押下時の処理
    void addPressed() {
      // 遷移処理
      context.push('/notice/register');
    }

    return Scaffold(
      key: _scaffoldKey, // 追加: Scaffold keyの設定
      endDrawer: FilterDrawer(), // 追加: FilterDrawerの設定
      backgroundColor: AppColors.main, //HACK:背景色パワープレイ！！
      body: Stack(children: [
        BasicTemplate(
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

        // TODO: ここのぼたんだけあればいいってやつ
        Positioned(
            bottom: 25,
            right: 25,
            child: AddButton(onPressed: addPressed)), // 追加ボタン
      ]),
    );
  }
}
