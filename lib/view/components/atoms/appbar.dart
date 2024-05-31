import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({
    super.key,
    required this.titleText,
    this.popIconButton,
    this.featureIconButton,
  });

  final String titleText;
  final IconButton? popIconButton;
  final IconButton? featureIconButton; // 必要なときとそうでないときがあるため、nullを許容する

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 左側のアイコン
      leading: popIconButton != null ? popIconButton : null,
      // タイトル
      title: Text(
        titleText,
        style: Fonts.titleFont,
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
