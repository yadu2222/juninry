import 'package:flutter/material.dart';
import '../atoms/con_item.dart';
import '../../../constant/colors.dart';

class ClassConTab extends StatelessWidget {
  const ClassConTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.only(right: 10, left: 10, top: 7, bottom: 5),
      decoration: BoxDecoration(color: AppColors.subjectJapanese, borderRadius: BorderRadius.circular(10)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ConItem(iconData: Icons.local_offer, title: '参加', movePage: '/home/join'),
          ConItem(iconData: Icons.local_offer, title: '作成', movePage: '/home/create'),
          ConItem(iconData: Icons.local_offer, title: '招待', movePage: '/home/invite')
        ],
      ),
    );
  }
}
