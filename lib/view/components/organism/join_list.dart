import 'package:flutter/material.dart';
import 'package:juninry/models/class_model.dart';
// import 'package:go_router/go_router.dart';

import '../atoms/listItem_box.dart';
import '../molecule/join_class_card.dart';

// 参加中のクラスリスト
class JoinList extends StatelessWidget {
  
  final bool isTeacher;
  final List<Class> joinClasses;
  final void Function(Class) invite;

  const JoinList({
    super.key,
    required this.isTeacher,
    required this.joinClasses,
    required this.invite,
  });




  @override
  Widget build(BuildContext context) {
    return ListItemBox<Class>(
      itemDatas: joinClasses,
      listItem: (item) => JoinClassCard(
        classData: item,
        onTap: invite,
        isTeacher: isTeacher,
      ),
    );
  }
}
