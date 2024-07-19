import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../router/router.dart';
// view
import '../../components/atoms/toast.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/info_form.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/molecule/invite_dialog.dart';
import '../../components/molecule/divider.dart';
import '../../components/organism/join_list.dart';
// api
import '../../../apis/controller/class_req.dart'; // リクエスト
// model
import '../../../models/class_model.dart';
// 定数
import '../../../constant/messages.dart';
// sample
import '../../../constant/sample_data.dart';


// OUCHIUUIDがないユーザーがとばされるページ
// 保護者は招待コード、子供は招待コード入力ページ
class PageOUCHI extends HookWidget {
  PageOUCHI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
