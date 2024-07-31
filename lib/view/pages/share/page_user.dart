import 'package:flutter/material.dart';
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
              negativeAction: ("いいえ", () {}),
              positiveAction: ("はい", () async {
                await _performLogout(context);
              }),
            );
          } else {
            _navigateToRoute(context, route); // ルートに遷移
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: noBottomBorder
                  ? BorderSide.none
                  : BorderSide(color: AppColors.glay, width: 2),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.iconGray, size: 35),
              const SizedBox(width: 20),
              Text(
                text,
                style: Fonts.h5.copyWith(color: textColor),
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
        SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  textColor: AppColors.buttonCheck),
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

  // 直接ログアウト処理を実行するメソッド
  Future<void> _performLogout(BuildContext context) async {
    bool isLogout = await User.logout();
    if (isLogout) {
      context.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ログアウトに失敗しました。もう一度お試しください。'),
        ),
      );
    }
  }
}
