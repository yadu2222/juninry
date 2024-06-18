import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/models/classes.dart';

class ClassDropdown extends StatefulWidget {
  final List<Classes> items;
  final void Function(Classes? value) onChanged;
  final Classes selectedClass;

  const ClassDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.selectedClass,
  });

  @override
  _ClassDropdownState createState() => _ClassDropdownState();
}

class _ClassDropdownState extends State<ClassDropdown> {
  late List<Classes> items;
  late Classes selectedClass;
  late Function(Classes? value) onChanged;

  @override
  void initState() {
    super.initState();
    items = widget.items;
    onChanged = widget.onChanged;
    selectedClass = widget.selectedClass;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _showPopupMenu();
          },
          child: Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.glay),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.glay, size: 25),
                Expanded(
                    //アイコン除いたところの中央に表示するやつ
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            selectedClass.className,
                            style:
                                const TextStyle(color: AppColors.fontDark)))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPopupMenu() async {
    // なんか知らんけど座標取得してどこに表示するか決めるよーってやつ
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;

    //右上基準にしたいよね
    final Offset buttonTopRight = button
        .localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);

    //右上基準でやるよ
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(buttonTopRight, buttonTopRight),
      Offset.zero & overlay.size,
    );

    //表示する中身だよ
    final Classes? tapedClass = await showMenu<Classes>(
      context: context,
      position: position,
      // アニメーションなんかあれば
      // popUpAnimationStyle: AnimationStyle.noAnimation,
      color: AppColors.iconLight,
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),

      //　中身だよ
      // 書き方がカスな気しかしない
      items: [
        // 一番上のガイドみたいなやつ
        PopupMenuItem<Classes>(
          enabled: false, // この項目は選択不可にする
          height: 30,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 30,
                child: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.subjectSocial, size: 25),
              ),
              Container(
                width: 100,
                alignment: Alignment.center,
                child: const Text(
                  'クラスを選択',
                  style: TextStyle(color: AppColors.fontDark),
                ),
              ),
            ],
          ),
        ),

        //区切り線
        const PopupMenuDivider(
          height: 0,
        ),

        //続く中身
        ...items.map((item) {
          return PopupMenuItem<Classes>(
              value: item,
              height: 30,
              child: Row(children: [
                SizedBox(
                  width: 30,
                  child: Icon(item == selectedClass ? Icons.check : null,
                      color: AppColors.subjectSocial, size: 15),
                ),
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    item.className,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]));
        })
      ],
    );

    // 選択されたらクラス更新するよ
    if (tapedClass != null && tapedClass != selectedClass) {
      // 二行必要な理由わからない、、、
      selectedClass = tapedClass;
      onChanged(tapedClass);
    }
  }
}
