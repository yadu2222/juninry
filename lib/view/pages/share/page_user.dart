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
import 'package:juninry/constant/colors.dart';
import '../../../constant/fonts.dart';
import '../../../models/user_model.dart';
import '../../components/template/basic_template.dart';

class PageUserData extends StatelessWidget {
  const PageUserData({super.key});

  final String title = 'ユーザー';

  @override
  Widget build(BuildContext context) {
    Widget _buildOption(IconData icon, String text, String route, {bool onLogout = false}) {
      return GestureDetector(
        onTap: () {
          if (onLogout) {
            logout(context);
          } else {
            context.go(route);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.iconGray, size: 30),
              const SizedBox(width: 20),
              Text(
                text,
                style: Fonts.p,
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _buildOption(Icons.person, 'マイページ', '/userData/myPage'),
              _buildOption(Icons.notifications_none_outlined, '通知', '/notifications'),
              _buildOption(Icons.message, 'LINE連携', '/line-integration'),
              _buildOption(Icons.help, 'よくある質問', '/settings/questions'),
              _buildOption(Icons.door_back_door, 'ログアウト', '', onLogout: true),
            ],
          ),
        ),
      ],
    );
  }

  // ログアウトメソッド
  void logout(BuildContext context) async {
    bool isLogout = await User.logout(); // dbからデータを削除
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
