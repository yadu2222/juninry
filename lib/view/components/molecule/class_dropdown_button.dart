import 'package:flutter/material.dart';
import 'package:juninry/models/classes.dart';

import '../../../constant/fonts.dart';

//セレクトボックス
class ClassDropdownButton extends StatefulWidget {
  final List<Classes> classesList;
  final void Function(Classes? value) onChanged;
  final Classes selectedClass;

  const ClassDropdownButton({
    super.key,
    required this.classesList,
    required this.onChanged,
    required this.selectedClass,
  });

  @override
  _ClassDropdownButtonState createState() => _ClassDropdownButtonState();
}

class _ClassDropdownButtonState extends State<ClassDropdownButton> {
  late Classes selectedClass;
  late List<Classes> classesList;

  @override
  void initState() {
    super.initState();
    classesList = widget.classesList;
    selectedClass = widget.selectedClass;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)), // 角丸: 10,  // 角丸
        child: DropdownButton<Classes>(
            value: selectedClass,
            items: classesList.map((Classes classes) {
              return DropdownMenuItem<Classes>(
                value: classes,
                child: Text(classes.className, style: Fonts.p),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedClass = value!;
              });
              widget.onChanged(value);
            }));
  }
}
