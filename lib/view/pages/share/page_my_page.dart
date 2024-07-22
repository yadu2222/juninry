import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import '../../components/template/basic_template.dart';
import '../../../constant/fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../apis/controller/homework_req.dart';
import '../../../models/user_model.dart';
import '../../components/atoms/background_circle.dart';
import '../../components/atoms/submission_record_dot.dart';
import '../../../models/homework_submission_record.dart';

class CurveClipper extends CustomClipper<Path> {
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

class PageMyPage extends HookWidget {
  const PageMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeworkReq = HomeworkReq(context: context);

    // 現在の日付と時刻を取得
    DateTime now = DateTime.now();

    // データ取得中だよ
    final isInitialized = useState(false);
    // おなまえ
    final name = useState("");

    // アイコンのために何かいるだろう。。。

    // 選択されている月を取得
    final focusedDayState =
        useState(DateTime.utc(now.year, now.month, 1, 0, 0, 0));

    // 提出データ
    final submissionData = useState([]);

    // カレンダーを日本語にするために頑張ってる（誰かわからないけど。。。)
    Future<void> _initializeLocale() async {
      await initializeDateFormatting('ja_JP', null);
      isInitialized.value = true;
    }

    // お名前頂戴します
    Future<void> _fetchName() async {
      name.value = await User.getUser().then((user) => user.userName);
    }

    Future<void> _fetchSubmissionLog(DateTime) async {
      submissionData.value =
          await homeworkReq.submissionLogHandler(focusedDayState.value);
    }

    // TODO: ユーザー名取得
    // TODO: ユーザーの性別取得
    // TODO: 課題提出状況取得 エンドポイント作成
    // 頑張ってそれらを反映させる
    useEffect(() {
      _fetchName();
      _initializeLocale();
      return null; // Cleanup function for useEffect, if needed
    }, []);

    // 月が変更されたらその月の提出状況を取得する
    useEffect(() {
      debugPrint(focusedDayState.value.toString());
      _fetchSubmissionLog(focusedDayState.value);
      return null;
    }, [focusedDayState.value]);

    return BasicTemplate(
      title: "マイページ",
      children: [
        Expanded(
          child: Stack(children: <Widget>[
            Container(
              // 背景色をコンテナで埋める
              color: AppColors.iconLight,
            ),
            const BackgroundCircle(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center, // ここで左右中央に配置
                children: [
                  const SizedBox(height: 5),
                  // TODO: アイコン人によって変えるよ
                  Container(
                    // アイコンの背景くん
                    width: 114,
                    height: 114,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconLight,
                    ),
                    child: const Icon(Icons.face_5,
                        color: AppColors.subjectMath, size: 110),
                  ),

                  Text(name.value, style: Fonts.h3),
                  const SizedBox(height: 10),
                  // TODO: トロフィーくん
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 中央揃え
                    children: List.generate(3, (index) {
                      return const Icon(Icons.emoji_events_outlined,
                          size: 50, color: AppColors.main);
                    }),
                  ),
                  const SizedBox(height: 20),
                  ListItem(
                    spreadRadius: 2,
                    height: 392,
                    padding: EdgeInsets.zero,
                    widget: isInitialized.value
                        ? TableCalendar(
                            firstDay: DateTime(2010, 1, 1),
                            lastDay: DateTime(2030, 1, 1),
                            focusedDay: focusedDayState.value,
                            locale: 'ja_JP',
                            onPageChanged: (focusedDay) {
                              focusedDayState.value = focusedDay;
                            },
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: false,
                            ),
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, date, events) {
                                // ここにマーカーを表示する
                                for (HomeworkSubmissionRecord record
                                    in submissionData.value) {
                                  if (date.day == record.limitDate.day) {
                                    return SubmissionRecordDot(record: record);
                                  }
                                }
                              },
                              todayBuilder: (context, day, focusedDay) {
                                return Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.main,
                                        ),
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          day.day.toString(),
                                          style: Fonts.pw,
                                        )));
                              },
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('データを取得中', style: Fonts.h3),
                              CircularProgressIndicator(),
                            ],
                          ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }
}
