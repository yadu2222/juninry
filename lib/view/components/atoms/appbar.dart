import 'package:flutter/material.dart';
import '../../../constant/fonts.dart';
import 'package:go_router/go_router.dart';

// AppBar
// 戻るボタンとタイトルと機能ボタンを表示する
class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({
    super.key,
    required this.titleText,
    this.popIconButton = false,
    this.featureIconButton,
    this.popFunction,
  });

  // 必ず必要
  final String titleText; // タイトル
  // null許容
  final bool popIconButton; // 左側のアイコン
  final IconButton? featureIconButton; // 右側のアイコン　必要なときとそうでないときがあるため、nullを許容する
  final bool Function()? popFunction; // 右側のアイコン タップ時の処理

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 左側のアイコン
      // 戻るボタンか空かの二択 これ以外は 許さない 絶対に
      leading: popIconButton
          // もどる
          ? IconButton(
              onPressed: () {
                // しょりものせれるようにしたよ
                // TODO:ぶすなのでなおす
                try {
                  if (popFunction != null) {
                    popFunction!();
                  } else {
                    context.pop(context);
                  }
                } catch (e) {
                  // errorってことは処理がなかったということ？
                  context.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 25,
              ),
            )
          // なんか入ってたら空にする
          : null,

      // タイトル
      centerTitle: true, // android向けにタイトルが真ん中であると明示する
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
