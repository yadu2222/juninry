import 'package:flutter/material.dart';
import 'package:juninry/view/components/molecule/user_card.dart';
import '../atoms/listItem_box.dart';
import '../../../models/user_model.dart';

// おてつだいリスト
class OuchiMembarList extends StatelessWidget {
  final List<User> users; // お手伝いリスト

  const OuchiMembarList({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return ListItemBox<User>(
      itemDatas: users,
      listItem: (userData) => UserCard(userData: userData),
    );
  }
}
