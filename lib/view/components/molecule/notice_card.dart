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

    size: 45,
  );

  final Icon checkIcon = const Icon(
    Icons.check_circle,
    color: AppColors.buttonOk,
    size: 45,
  );

  @override
  Widget build(BuildContext context) {



    return ListItem(
      padding: EdgeInsets.only(top: 5,bottom: 10,left: 10,right: 10),
      // 表示する要素を配置
      widget: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Rowの子ウィジェットを左右に配置
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを左揃えに設定
            
            children: [
              Row(
                
                children: [
                  // 日付け
                  Container(
                    child: Text(
                      noticeData.noticeDate,
                      style: Fonts.h2,
                    ),
                    margin: const EdgeInsets.only(left: 10),
                    
                  ),

                  //日時と学年のテキスト間のスペースを設定
                  SizedBox(width: 18),

                  //学年
                  Container(
                    child: Text(
                      noticeData.className,
                      style: Fonts.h4y,
                    ),
                  )
                ],
              ),

              // 見出し
              Container(
                child: Text(
                  noticeData.noticeTitle,
                  style: Fonts.p,
                ),
                margin: const EdgeInsets.only(left: 10),
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
