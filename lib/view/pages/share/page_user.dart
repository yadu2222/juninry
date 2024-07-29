// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../constant/fonts.dart';
// import '../../../view/components/atoms/basic_button.dart';
// import '../../../models/user_model.dart';
// import '../../components/template/basic_template.dart';

// class PageUserData extends StatelessWidget {
//   const PageUserData({super.key,});

//   final String title = 'ユーザー';

//   @override
//   Widget build(BuildContext context) {
//     void logout() async {
//       // ログアウト処理
//       bool isLogout = await User.logout();  // dbからデータを削除
//       if (isLogout) {
//         // ログイン画面に遷移
//        context.go('/login');
//       } else {}
//     }

//     return BasicTemplate(title: title, children: [
//       const Text('ユーザー情報', style: Fonts.h3),
//       BasicButton(
//         text: 'ログアウト',
//         isColor: false,
//         onPressed: () {
//           logout();
//         },
//       ),
//     ]);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';
import '../../../models/user_model.dart';
import '../../components/template/basic_template.dart';
import '../../components/atoms/alert_dialog.dart';

class PageUserData extends StatelessWidget {
  const PageUserData({super.key});

  final String title = 'ユーザー';

  @override
  Widget build(BuildContext context) {
    // オプション項目を構築するウィジェット
    Widget _buildOption(
      IconData icon,
      String text,
      String route, {
      bool onLogout = false,
      bool noBottomBorder = false,
      Color textColor = Colors.black,
    }) {
      return GestureDetector(
        onTap: () {
          if (onLogout) {
            AlertDialogUtil.show(
              context: context,
              content: "ログアウトしますか？",
              positiveAction: ("はい", () async _performLogout(context))
            )
            _showLogoutConfirmationDialog(context); // 確認ダイアログを表示
          } else {
            _navigateToRoute(context, route); // ルートに遷移
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white, // 背景色を白に設定
            border: Border(
              bottom: noBottomBorder
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.withOpacity(0.3)), // 下線を設定
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.iconGray, size: 30), // アイコン
              const SizedBox(width: 20), // アイコンとテキストの間にスペースを追加
              Text(
                text,
                style: Fonts.p.copyWith(color: textColor), // テキストスタイルを適用し、文字色を指定
              ),
            ],
          ),
        ),
      );
    }

    return BasicTemplate(
      title: '設定',
      popIcon: false,
      children: [
        SizedBox(height: 20), // 「設定」と要素の間の空間を広げる
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),

          ),
          child: Column(
            children: [
              _buildOption(Icons.person, 'マイページ', '/mypage'),
              _buildOption(Icons.notifications, '通知', '/notifications'),
              _buildOption(Icons.message, 'LINE連携', '/line-integration'),
              _buildOption(Icons.help, 'よくある質問', '/settings/questions'),
              _buildOption(Icons.meeting_room, 'ログアウト', '',
                  onLogout: true,
                  noBottomBorder: true,
                  textColor: AppColors.buttonCheck), // ログアウトの文字色を指定
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToRoute(BuildContext context, String route) {
    if (route.isNotEmpty) {
      context.go(route);
    }
  }

  // 確認ダイアログを表示するメソッド
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // ダイアログの外をタップしても閉じない
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'ログアウトしますか？',
                textAlign: TextAlign.center,
                style: Fonts.h2.copyWith(
                  color: AppColors.buttonCheck,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // フォントサイズを調整
                ),
              ),
              SizedBox(height: 8), // タイトルと下線の間の余白を減らす
              Divider(
                color: Colors.grey.withOpacity(0.5), // 下線の色
                thickness: 1, // 下線の太さ
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('キャンセル'),
                  onPressed: () {
                    Navigator.of(context).pop(); // ダイアログを閉じる
                  },
                ),
                TextButton(
                  child: Text(
                    'ログアウト',
                    style: TextStyle(color: AppColors.buttonCheck),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop(); // ダイアログを閉じる
                    await Future.delayed(Duration(milliseconds: 100)); // 少し待ってからログアウト処理を実行
                    await _performLogout(context); // ログアウト処理を実行
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // 直接ログアウト処理を実行するメソッド
  Future<void> _performLogout(BuildContext context) async {
    bool isLogout = await User.logout(); // DBからデータを削除
    if (isLogout) {
      context.go('/login'); // ログイン画面に遷移
    } else {
      // エラーハンドリングを追加
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ログアウトに失敗しました。もう一度お試しください。'),
        ),
      );
    }
  }
}
