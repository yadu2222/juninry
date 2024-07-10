import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../../components/template/scroll_template.dart';
import '../../components/organism/help_list.dart';
// model
import '../../../models/help_model.dart';
// sample
import '../../../constant/sample_data.dart';

class PageOuchiJunior extends HookWidget {
  const PageOuchiJunior({super.key});

  final String title = 'おうち';
  @override
  Widget build(BuildContext context) {
    final helpData = useState<List<Help>>(SampleData.helpData); // データを格納するための変数
    void onTap(Help helpData) {
      // おてつだい消化処理
      // 保護者に確認を取るべきでは？
      helpData.isReword = true;
    }

    return ScrollTemplate(title: title, children: [
      // ここにおうちのコンテンツを追加
      // たまっているポイント
      // GHOUBI交換所あるよという主張
      // おてつだい一覧(デイリーミッションなかんじ)
      Helplist(helps: helpData.value, onTap: onTap)
    ]);
  }
}
