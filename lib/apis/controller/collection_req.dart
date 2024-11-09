import 'package:flutter/material.dart';

import '../service/collection_service.dart';
// import 'package:go_router/go_router.dart';
import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';
import '../../models/collection_model.dart';
// import '../../view/components/atoms/dialog.dart';
// import '../error.dart';

class CollectionReq {
  final BuildContext context;

  CollectionReq({required this.context});

  // ニャリオット一覧を取得
  Future<List<Collection>> getItems() {
    try {
      return CollectionService.getItems();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return Future.value(<Collection>[]); // 空の Future<List<Collection>> を返す
    }
  }
}
