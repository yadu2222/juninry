import 'package:flutter/material.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/models/class_model.dart';

class ClassDropdown extends StatefulWidget {
  final List<Class> items;
  final void Function(Class value) onChanged;
  final Class selectedClass;

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
  late Function(Class value) onChanged;

  @override
  void initState() {
    super.initState();
    onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // 引用、所属クラスが1など、選択肢が存在しない場合、せんたくしをひらかない
            if (widget.items.length != 1) {
              _showPopupMenu();
            }
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
                Icon(
                    // ドロップダウンでない場合はチェックマーク
                    (widget.items.length == 1)
                        ? Icons.done
                        : Icons.keyboard_arrow_down,
                    color: AppColors.glay,
                    size: 25),
                Expanded(
                    //アイコン除いたところの中央に表示するやつ
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.selectedClass.className,
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
    final Class? tapedClass = await showMenu<Class>(
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
        PopupMenuItem<Class>(
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
        ...widget.items.map((item) {
          return PopupMenuItem<Class>(
              value: item,
              height: 30,
              child: Row(children: [
                SizedBox(
                  //選択しているクラスは目印
                  width: 30,
                  child: Icon(
                      item.classUuid == widget.selectedClass.classUuid
                          ? Icons.check
                          : null,
                      color: AppColors.subjectSocial,
                      size: 15),
                ),
                Container(
                  //クラス名
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
    if (tapedClass != null && tapedClass != widget.selectedClass) {
      onChanged(tapedClass);
    }
  }
}
