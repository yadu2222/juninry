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

  // アイテム一覧を取得
  Future<List<Collection>> getItems() {
    try {
      return CollectionService.getItems();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return Future.value(<Collection>[]); // 空の Future<List<Collection>> を返す
    }
  }

  // ニャリオット一覧を取得
  Future<List<Collection>> getNyariots() {
    try {
      return CollectionService.getNyariots();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return Future.value(<Collection>[]); // 空の Future<List<Collection>> を返す
    }
  }

  // スタンプの数を取得
  Future<int> getStamps() {
    try {
      return CollectionService.getStamps();
    } catch (error) {
      ToastUtil.show(message: "おわんないよ〜〜");
      return Future.value(0); // 空の Future<int> を返す
    }
  }
}
