import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../service/user_service.dart';
import 'package:go_router/go_router.dart';

import '../../view/components/atoms/toast.dart';
import '../../../constant/messages.dart';



// お知らせ取得
  Future<User> getNotice() async {
    try{
      return UserService.getUser();
    }catch(error){
      ToastUtil.show(message: Messages.getUserError);
      return User.errorUser();    // 取得エラー
    }
  }