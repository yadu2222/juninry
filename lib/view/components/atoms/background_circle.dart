import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40; //曲線の高さ

    Path path = Path()
      ..lineTo(0, size.height - curveHeight) //lineTo()は指定した座標まで直線を引く
      ..quadraticBezierTo(
        size.width / 2,
        size.height + curveHeight,
        size.width,
        size.height - curveHeight,
      )
//quadraticBezierTo(コントロールポイントのx座標, コントロールポイントのy座標, 最終地点のx座標,最終地点のy座標)
      ..lineTo(size.width, 0) //直線
      ..close(); //最初の位置まで戻る

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BackgroundCircle extends StatelessWidget {
  const BackgroundCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        child: ClipPath(
          clipper: _CurveClipper(),
          child: Container(
            color: AppColors.main,
            height: 80,
            width: 393,
          ),
        ));
  }
}
