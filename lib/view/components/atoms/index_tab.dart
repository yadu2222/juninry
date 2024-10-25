import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';

class IndexTab extends StatelessWidget {
  const IndexTab({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
    this.margin = const EdgeInsets.all(0),
  });

  final bool isSelected;
  final void Function() onTap;
  final IconData icon;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: 170,
          height: 40,
          margin: margin,
          decoration: BoxDecoration(
            color: AppColors.iconLight,
            // 角丸 上だけ
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: isSelected
                ? const Border(
                    top: BorderSide(color: AppColors.subjectSocial, width: 2),
                    left: BorderSide(color: AppColors.subjectSocial, width: 2),
                    right: BorderSide(color: AppColors.subjectSocial, width: 2),
                  )
                : null,
          ),
          child: Icon(
            icon,
            color: AppColors.main,
          ),
        ));
  }
}
