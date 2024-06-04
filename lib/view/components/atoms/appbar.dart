import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import 'package:go_router/go_router.dart';


// AppBar
// 戻るボタンとタイトルと機能ボタンを表示する
class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({
    super.key,
    required this.titleText,
    this.popIconButton,
    this.featureIconButton,
  });


  // 必ず必要
  final String titleText;           // タイトル
  // null許容
  final IconButton? popIconButton;  // 左側のアイコン
  final IconButton? featureIconButton; // 右側のアイコン　必要なときとそうでないときがあるため、nullを許容する

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 左側のアイコン
      // 戻るボタンか空かの二択 これ以外は 許さない 絶対に
      leading: popIconButton == null
          // もどる
          ? IconButton(
              onPressed: () {
                // TODO: 戻る先がなくても出しゃばってきてエラー吐くので修正
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 35,
              ),
            )
          // なんか入ってたら空にする
          : null,

      // タイトル
      title: Text(
        titleText,
        style: Fonts.titleFont,
      ),
      // 右側のアイコン
      // nullチェック !でnullでないことを保証
      actions: featureIconButton != null ? <Widget>[featureIconButton!] : [],
    );
  }

  // 高さの設定
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
