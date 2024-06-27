import 'package:flutter/material.dart';
import '../../components/atoms/listItem_box.dart';
import '../../../models/register_homework_model.dart';
import '../molecule/register_homework_card.dart';

class RegisterHomeworkList extends StatelessWidget {
  const RegisterHomeworkList({super.key, required this.registerHomeworkData,required this.onTap});

  final List<RegisterHomework> registerHomeworkData;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ListItemBox<RegisterHomework>(
        itemDatas: registerHomeworkData,
        listItem: (registerHomework) => InkWell(
              onTap: () {
                // onTap(registerHomeworkData.indexOf(registerHomework));
              },
              child: RegisterHomeworkCard(registerHomeworkData: registerHomework,index: registerHomeworkData.indexOf(registerHomework),onTap: onTap,),
            ));
  }
}
