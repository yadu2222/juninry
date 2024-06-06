import 'package:flutter/material.dart';
import 'package:juninry/view/components/atoms/appbar.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import '../../components/molecule/divider.dart';

class PageNoticeDetail extends StatelessWidget {
  const PageNoticeDetail({super.key});

  // fields
  final String title = "おしらせ詳細";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppBarView(titleText: title), // app bar  // TODO: リンクアイコン

          // 最新のお知らせ
          // 明日までの宿題  TODO: バー
          const DividerView(
            icon: Icons.menu_book_outlined,
            title: '確認状況',
          ),
        ],
      ),
    );
  }
}
