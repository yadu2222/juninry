import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../components/organism/picture_list.dart';
import '../../components/molecule/homework_card.dart';
import '../../components/molecule/divider.dart';

// import '../../../models/homework_model.dart';
import '../../components/template/basic_template.dart';
import '../../../constant/sample_data.dart'; // sampleData
import 'dart:io';

// 提出ページ
class PageSubmissionPatron extends HookWidget {
  final String homeworkUUId;
  const PageSubmissionPatron({
    super.key,
    required this.homeworkUUId,
  });

  final String title = '提出状況';

  @override
  Widget build(BuildContext context) {
    // TODO: ここでIDを元に提出が必要な課題データを取得する処理を追加
    // 画像ファイルを定義？
    final List<File> images = []; // ここに取得した画像ファイルを格納したい
    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      HomeworkCard.teacher(homeworkData: SampleData.homeworkData[0]), // 課題カード
      const DividerView(), // 区切り線
      // 提出リスト
      Expanded(child: PictureList(images: images))
    ] // 提出リスト
        );
  }
}
