import 'package:flutter/material.dart';
import 'package:juninry/view/components/template/basic_template.dart';
import '../../components/atoms/listItem_box.dart';
import '../../../constant/help.dart';
import '../../components/molecule/question_card.dart';

class PageQuestions extends StatelessWidget {
  const PageQuestions({super.key});

  final String title = 'よくある質問';
  @override
  Widget build(BuildContext context) {
    return BasicTemplate(title: title, children: [
      const SizedBox(
        height: 10,
      ),
      Expanded(
          child: ListItemBox<Question>(
        itemDatas: Question.questionAndAnser,
        listItem: (question) => QuestionCard(question: question),
      ))
    ]);
  }
}
