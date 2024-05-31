import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../atoms/appbar.dart';
import '../atoms/screenview.dart';
import '../atoms/bottombar.dart';
import '../../../constant/colors.dart';

// 遷移先
import '../../pages/junior/page_home.dart';
import '../../pages/junior/page_homework.dart';
import '../../pages/junior/page_notice.dart';
import '../../pages/junior/page_user.dart';

/**
 * ホーム画面以外の雛形
 */
class BasicScreenView extends StatefulWidget {
  const BasicScreenView({
    super.key,
    required this.title,
    required this.widget,
    this.featureIconButton,
  });
  final String title;
  final Widget widget;
  final IconButton? featureIconButton;
  @override
  _BasicScreenViewState createState() => _BasicScreenViewState();
}

class _BasicScreenViewState extends State<BasicScreenView> {
  int _selectedIndex = 0;

  // 遷移先のリスト
  static const List<Widget> _widgetOptions = <Widget>[
    PageHomeJunior(),
    PageNoticeJunior(),
    PageHomeworkJunior(),
    PageUserDataJunior(),
  ];

  void _onItemTapped(int index) {
    
    setState(() {
      // 遷移先を変更
      // 今選択している値と比較
      if (_selectedIndex != index) {
        _selectedIndex = index;
        debugPrint('selectedIndex changed: $_selectedIndex');

        // 遷移
        // TODO:おなじなら遷移したくないじゃん？？？できてない
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _widgetOptions[_selectedIndex]),
          // TODO:遷移のアニメーションを変えたい
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      appBar: AppBarView(
        titleText: widget.title,
        popIconButton: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.iconLight,
            size: 35,
          ),
        ),
        featureIconButton: widget.featureIconButton,
      ),
      widget: widget.widget,
      bottomBar: BottomBarView(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
