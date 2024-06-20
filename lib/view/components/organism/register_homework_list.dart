import 'package:flutter/material.dart';
import '../../components/atoms/listItem_box.dart';
import '../../../models/register_homework_model.dart';
import '../molecule/register_homework_card.dart';

class RegisterHomeworkList extends StatelessWidget {
  const RegisterHomeworkList({super.key, required this.registerHomeworkData});

  final List<RegisterHomework> registerHomeworkData;

  @override
  Widget build(BuildContext context) {
    return ListItemBox<RegisterHomework>(
        itemDatas: registerHomeworkData,
        listItem: (registerHomework) => InkWell(
              onTap: () {
                // onTap(index);
              },
              child: RegisterHomeworkCard(registerHomeworkData: registerHomework),
            ));
  }
}
