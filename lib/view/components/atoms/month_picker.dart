import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';



// TODO: あったら嬉しいね年月ピッカー実装本部
class CustomPicker extends CommonPickerModel {
  CustomPicker({
    required DateTime focusedDay,
    required LocaleType locale,
  }) : super(locale: locale) {
    // 左のホイールは年を選択
    setLeftIndex(focusedDay.year);
    // 中央のホイールは月を選択
    setMiddleIndex(focusedDay.month);
    // 秒は使わないので0を渡しておく（指定しないと LateInitializationError になる）
    setRightIndex(0);
  }

  // value を length で指定された桁数で表示する。
  // 桁数が足りないときは 0 埋めする
  // ※ライブラリ内で定義されている関数を移植した
  String digits(int value, int length) => '$value'.padLeft(length, '0');

  @override
  // 時の表示文字列を要素の index から生成
  // null を返せば選択肢として表示されない
  String? leftStringAtIndex(int index) {
    if (index >= 2010 && index < 2030) {
      //2010 ~ 2030 の年を表示
      return digits(index, 4);
    } else {
      // それ以外の要素は表示させない
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 12) {
      // 1 ~ 12 の月を表示
      return digits(index, 2);
    } else {
      return null;
    }
  }

  // @override
  // // 時と分の間の Divider 文字列
  // String leftDivider() => ':';

  @override
  // 分と秒の間の Divider 文字列
  // 秒を表示しないので空文字を返しておく
  String rightDivider() => '';

  @override
  // 時、分、秒のそれぞれの列の幅の比率
  // 秒は使わないので 0 を指定
  List<int> layoutProportions() => [1, 1, 0];

  @override
  DateTime finalTime() {
    return DateTime.utc(currentLeftIndex(), currentMiddleIndex() + 1, 0);
  }
}
