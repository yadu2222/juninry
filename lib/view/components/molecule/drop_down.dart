import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

class DropDownUtil extends StatelessWidget {
  const DropDownUtil({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
  });

  final List<Map<String, dynamic>> items; // 表示するリスト
  final Function(int?) onChanged;
  final int? value; // 初期値
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        decoration: const BoxDecoration(
          color: AppColors.iconLight,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: DropdownButton<int>(
          value: value,
          hint: hint != null
              // hinttext
              ? Text(
                  hint!,
                )
              : null,
          icon: const Icon(Icons.arrow_downward, color: AppColors.iconLight),
          iconSize: 24,
          style: const TextStyle(color: AppColors.font),
          dropdownColor: AppColors.iconLight,
          onChanged: onChanged,
          underline: Container(),
          items: items.map<DropdownMenuItem<int>>((Map<String, dynamic> item) {
            return DropdownMenuItem<int>(
              value: item['value'],
              child: Text(item['display']),
            );
          }).toList(),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ));
  }
}
