import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/view/components/atoms/basic_button.dart';
import 'package:juninry/view/components/molecule/divider.dart';
import '../../../constant/fonts.dart';
import '../../../models/class_model.dart'; // クラスモデルをインポート

class FilterDrawer extends StatefulWidget {
  Map<int, bool> readStatusFilter; // 未確認フィルタ
  bool readFilterEnabled;
  List<Class> classList; // 所属クラス
  List<String> classListFilter; // 取得クラスの絞り込み
  void Function(bool value, Class item) onClassListChanged;
  void Function(bool value) onAllClassListChanged;
  void Function() refreshNotices;

  FilterDrawer(
      {this.readStatusFilter = const {},
      this.readFilterEnabled = false,
      required this.classList,
      required this.classListFilter,
      required this.onClassListChanged,
      required this.onAllClassListChanged,
      required this.refreshNotices,
      super.key});

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {

  @override
  void initState() {
    super.initState();
  }


  final Icon checkIcon = const Icon(
    Icons.check,
    color: AppColors.iconDark,
    size: 24,
  );

  @override


  @override

  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: AppColors.iconLight,  // XXX: 色設定するとそれはそれできもい
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 角を四角に設定
      ),
      child: Column(
        children: [
          // ドロワーのヘッダー部分
          Container(
            height: kToolbarHeight +
                MediaQuery.of(context).padding.top, // ツールバーの高さ + 画面上部の余白
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top), // 画面上部の余白
            color: AppColors.main,
            child: Stack(
              // 自由な位置に配置するぞ！の親
              children: [
                Positioned(
                    // 自由な位置に配置するぞ！の子
                    right: (MediaQuery.of(context).size.width - 200) /
                        2, // 全体の横幅引くSizedBoxの幅の半分
                    child: const SizedBox(
                      // テキストに横幅を設置できないので使われた人
                      width: 200, // 横幅君
                      height: kToolbarHeight, // ツールバーの高さに合わせる
                      child: Center(
                        // テキストに横幅を設置できないので使われた人
                        child: Text(
                          '絞り込み',
                          style: Fonts.titleFont,
                        ),
                      ),
                    )),
              ],
            ),
          ),

          // 絞り込みメニュー
          !widget.readFilterEnabled
              ? Container()
              : Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const DividerView(
                    icon: Icons.bookmark_border_outlined,
                    iconColor: AppColors.iconMiddleGray,
                    title: '確認状況',
                    fontStyle: Fonts.h3,
                    dividColor: AppColors.main,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ...widget.readStatusFilter.entries.map((entry) {
                    return _tile(
                      title: entry.key == 0 ? '未確認' : '確認済み',
                      value: entry.value,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.readStatusFilter[entry.key] = value!;
                        });
                      },
                    );
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                ]),

          const SizedBox(
            height: 15,
          ),
          const DividerView(
            icon: Icons.menu_book,
            iconColor: AppColors.iconMiddleGray,
            title: 'クラス選択',
            fontStyle: Fonts.h3,
            dividColor: AppColors.main,
            indent: 10,
            endIndent: 10,
          ),

          // クラスのリスト
          Expanded(

            child: ListView(
              padding: const EdgeInsets.only(top: 0),
              children: [
                _tile(
                    title: '全選択/解除',
                    value: widget.classListFilter.length ==
                        widget.classList.length,
                    onChanged: (bool? value) {
                      widget.onAllClassListChanged(value!);
                    }),
                ...widget.classList.map((item) => _tile(
                      title: item.className,
                      value: widget.classListFilter.contains(item.classUUID!),
                      onChanged: (bool? value) {
                        if (value == null) return;

                        widget.onClassListChanged(
                            value, item); // pages内のクラスリストを変更する
                      },
                    )),
              ],

            ),
          ),

          // 選択されたクラスを表示するボタン
          Align(
            alignment: Alignment.bottomCenter,
            child: BasicButton(
              text: '適用',
              onPressed: () {

                widget.refreshNotices();

                Navigator.pop(context); // ドロワーを閉じる
              },
              isColor: true,
            ),
            // child: Container(
            //     width: MediaQuery.of(context).size.width * 0.45,
            //     margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         widget.refreshNotices();
            //         Navigator.pop(context); // ドロワーを閉じる
            //       },
            //       style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           backgroundColor: AppColors.iconLight),
            //       child: Row(
            //         children: [
            //           // Container(
            //           //   decoration: BoxDecoration(
            //           //     color: AppColors.main,
            //           //     borderRadius: BorderRadius.circular(30),
            //           //   ),
            //           //   padding: const EdgeInsets.all(4),
            //           //   child: const Icon(
            //           //     Icons.notifications_none,
            //           //     color: AppColors.iconLight,
            //           //     size: 20,
            //           //   ),
            //           // ),
            //           Expanded(
            //             child: Container(
            //               alignment: Alignment.center, // 残りのスペースの中央に配置
            //               child: const Text('絞り込み適用', style: Fonts.p),
            //             ),
            //           ),
            //         ],
            //       ),
            //     )),
          )
        ],
      ),
    );
  }

  Widget _tile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.main,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.main;
                  }
                  return Colors.transparent;
                },
              ),
              side: const BorderSide(color: AppColors.main, width: 2),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Fonts.h4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
