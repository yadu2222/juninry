import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:juninry/apis/service/class_service.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/models/req_model.dart';
import 'package:juninry/view/components/molecule/divider.dart';
import '../../../constant/fonts.dart';
import '../../../models/class_model.dart'; // クラスモデルをインポート

class FilterDrawer extends StatefulWidget {
  Map<(String, int), bool> readStatusFilter; // 未確認フィルタ
  List<Class> classList; // 所属クラス
  List<Class> classListFilter; // 取得クラスの絞り込み
  void Function(bool value, Class item) onClassListChanged;
  void Function() refreshNotices;

  FilterDrawer(
      {required this.readStatusFilter,
      required this.classList,
      required this.classListFilter,
      required this.onClassListChanged,
      required this.refreshNotices,
      super.key});

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  bool _isConfirmedSelected = false; // 確認済みフィルタが選択されているかどうか
  bool _isUnconfirmedSelected = false; // 未確認フィルタが選択されているかどうか
  late bool _selectAll; // すべてのクラスが選択されているかどうか

  Map<String, bool> _selectedClass =
      {}; // HACK: チェックボックス用のマップ widget.classListFilterを直接参照してくれないよ

  @override
  void initState() {
    super.initState();

    _selectedClass = {
      for (Class item in widget.classList)
        item.classUUID!: widget.classListFilter.contains(item)
    };

    _selectAll = widget.classListFilter.length == widget.classList.length;
  }

  void _checkAllClassSelected() {
    if (widget.classListFilter.length == widget.classList.length) {
      _selectAll = true;
    } else {
      _selectAll = false;
    }
  }

  ScrollController _scrollController = ScrollController(); // スクロールコントローラー

  final Icon checkIcon = const Icon(
    Icons.check,
    color: AppColors.iconDark,
    size: 24,
  );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 角を四角に設定
      ),
      child: Column(
        children: <Widget>[
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
          widget.readStatusFilter.isEmpty
              ? Container()
              : const DividerView(
                  title: '既読ステータス',
                  fontStyle: Fonts.h3,
                  dividColor: AppColors.main,
                  indent: 10,
                  endIndent: 10,
                ),
          ...widget.readStatusFilter.entries.map((entry) {
            return _tile(
              title: entry.key.$1,
              value: entry.value,
              onChanged: (bool? value) {
                setState(() {
                  widget.readStatusFilter[entry.key] = value!;
                });
              },
            );
          }),
          // _tile(
          //   title: '確認済み',
          //   value: _isConfirmedSelected,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       _isConfirmedSelected = !_isConfirmedSelected;
          //     });
          //   },
          // ),
          // _tile(
          //   title: '未確認',
          //   value: _isUnconfirmedSelected,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       _isUnconfirmedSelected = !_isUnconfirmedSelected;
          //     });
          //   },
          // ),

          const DividerView(
            title: 'クラス選択',
            fontStyle: Fonts.h3,
            dividColor: AppColors.main,
            indent: 10,
            endIndent: 10,
          ),
          // クラスのリスト
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              controller: _scrollController,
              children: [
                _tile(
                    title: '全選択/解除',
                    value: _selectAll,
                    onChanged: (bool? value) {
                      // 全選択の状態を反転する
                      setState(() {
                        _selectAll = !_selectAll;
                      });
                      // 全件選択されている場合は全件解除する
                      _selectedClass.forEach(
                        (String key, bool value) {
                          if (value != _selectAll) {
                            // 状態を変更する必要のある場合
                            if (value) {
                              // 選択されている場合
                              widget.classListFilter
                                  .removeWhere((item) => item.classUUID == key);
                            } else {
                              // 選択されていない場合
                              widget.classListFilter.add(
                                // UUIDが一致するクラスを追加
                                widget.classList.firstWhere(
                                    (item) => item.classUUID == key),
                              );
                            }
                          }
                          _selectedClass[key] =
                              _selectAll; // 選択状態を_selectAllと同一にする
                        },
                      );
                    }),
                ...widget.classList.map((item) => _tile(
                      title: item.className,
                      value: _selectedClass[item.classUUID] ?? false,
                      onChanged: (bool? value) {
                        if (value == null) return;
                        setState(() {
                          // ローカルクラスの選択状態を変更する
                          _selectedClass[item.classUUID!] = value;
                        });
                        widget.onClassListChanged(
                            value, item); // pages内のクラスリストを変更する
                        _checkAllClassSelected(); // 全選択の状態を確認する
                      },
                    )),

                // 選択されたクラスを表示するボタン
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.refreshNotices();
                        Navigator.pop(context); // ドロワーを閉じる
                      },
                      child: Text('選択されたクラスを表示'),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
        height: 40,
        alignment: Alignment.center,
        child: CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Fonts.h4,
            ),
            value: value,
            onChanged: onChanged));
  }
}
