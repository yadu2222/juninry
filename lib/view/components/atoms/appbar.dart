import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({
    super.key,
    required this.titleText,
    this.featureIconButton,
  });

  final String titleText;
  final IconButton? featureIconButton; // 必要なときとそうでないときがあるため、nullを許容する

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 左側のアイコン
      leading: IconButton(
        onPressed: () {
          // 一つ前にもどる
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.iconLight,
          size: 35,
        ),
      ),
      // タイトル
      title: Text(
        titleText,
        style: Fonts.h1,
      ),
      backgroundColor: AppColors.main,
      // 右側のアイコン
      // nullチェック　!でnullでないことを保証
      actions: featureIconButton != null ? <Widget>[featureIconButton!] : [],
    );
  }

  // 高さの設定
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
