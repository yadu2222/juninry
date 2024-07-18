import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import '../../../models/notice_model.dart';
import '../atoms/listitem.dart';
import '../../../constant/fonts.dart';

// お知らせカード
class NoticeCard extends StatelessWidget {
  NoticeCard({
    super.key,
    required this.noticeData,
  });

  // お知らせデータ
  final Notice noticeData;

  // 未確認アイコン
  final Icon unknowIcon = const Icon(
    Icons.error_outline,
    color: AppColors.buttonCheck,
    size: 40,
  );

  final Icon checkIcon = const Icon(
    Icons.check_circle,
    color: AppColors.buttonOk,
    size: 40,
  );

  @override
  Widget build(BuildContext context) {



    return ListItem(
      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
      margin:const  EdgeInsets.only(top: 18),
      // 表示する要素を配置
      widget: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Rowの子ウィジェットを左右に配置
        crossAxisAlignment: CrossAxisAlignment.center, // Rowの子ウィジェットを中央に配置

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃えに設定

            children: [
              Row(

                children: [
                  // 日付け
                  Container(
                    child: Text(

                      noticeData.noticeDate!,
                      style: Fonts.h3,

                    ),
                    margin: const EdgeInsets.only(left: 10),

                  ),

                  //日時と学年のテキスト間のスペースを設定
                  SizedBox(width: 18),

                  //学年
                  Container(
                    child: Text(
                      noticeData.className!,
                      style: Fonts.h4y,
                    ),
                  )
                ],
              ),

              // 見出し
              Container(
                child: Text(
                  noticeData.noticeTitle,
                  style: Fonts.h4,
                ),
                // margin: const EdgeInsets.only(left: 1),
              ),
            ],
          ),

          // アイコン
            Container(
              alignment: Alignment.center,
              child: Center(
                  child:
                      // 未確認かを判別
                      // TODO:条件文分かり次第変更
                      noticeData.readStatus == '1' ? checkIcon : unknowIcon),
            ),
        ],
      ),
  
    );
  }
  
}
