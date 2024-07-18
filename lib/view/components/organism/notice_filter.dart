import 'package:flutter/material.dart';
import 'package:juninry/apis/service/class_service.dart';
import 'package:juninry/constant/colors.dart';
import '../../../constant/fonts.dart';
import '../../../models/class_model.dart'; // クラスモデルをインポート

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  bool _isConfirmedSelected = false; // 確認済みフィルタが選択されているかどうか
  bool _isUnconfirmedSelected = false; // 未確認フィルタが選択されているかどうか
  bool _selectAll = false; // すべてのクラスが選択されているかどうか
  Map<String, bool> _selectedClass = {}; // 選択されたクラスを保持するマップ
  ScrollController _scrollController = ScrollController(); // スクロールコントローラー

  final Icon checkIcon = const Icon(
    Icons.check,
    color: AppColors.iconDark,
    size: 24,
  );

  @override

  void initState() {
    super.initState();
    _fetchClasses(); // クラス情報を取得するメソッドを呼び出し
  }

  // クラス情報をAPIから取得するメソッド
  void _fetchClasses() async {
    // APIからのクラス情報の取得
    List<Class> classes = await ClassService.getClasses(); // このメソッドは実際のデータ取得方法に置き換える必要があります

    setState(() {
      // 取得したクラス情報をもとに_selectedClassを初期化
      _selectedClass = Map.fromIterable(
        classes,
        key: (classInfo) => classInfo.className,
        value: (classInfo) => false, // 最初はすべてのクラスが未選択になるように設定
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // すべてのクラスの選択状態を切り替えるメソッド
  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll; // _selectAllの状態を反転
      _selectedClass.updateAll((key, value) => _selectAll); // すべてのクラスの選択状態を更新
    });
  }

  // 選択されたクラス名のリストを取得するメソッド
  List<String> _getSelectedClasses() {
    return _selectedClass.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 角を四角に設定
      ),
      child: Column(
        children: <Widget>[
          // ドロワーのヘッダー部分
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.main,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 30, left: 30),
            child: Text(
              '絞り込み',
              style: Fonts.h2w,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 未確認フィルタボタン
                _buildFilterButton(
                  title: '未確認',
                  isSelected: _isUnconfirmedSelected,
                  onTap: () {
                    setState(() {
                      _isUnconfirmedSelected = !_isUnconfirmedSelected;
                      if (_isUnconfirmedSelected) {
                        _isConfirmedSelected = false;
                      }
                    });
                  },
                ),
                // 確認済みフィルタボタン
                _buildFilterButton(
                  title: '確認済み',
                  isSelected: _isConfirmedSelected,
                  onTap: () {
                    setState(() {
                      _isConfirmedSelected = !_isConfirmedSelected;
                      if (_isConfirmedSelected) {
                        _isUnconfirmedSelected = false;
                      }
                    });
                  },
                ),
                // 全件選択/全件解除ボタン
                _buildFilterButton(
                  title: _selectAll ? '全件解除' : '全件選択',
                  isSelected: _selectAll,
                  onTap: _toggleSelectAll,
                ),
                Divider(thickness: 3.0), // 仕切り線
              ],
            ),
          ),
          // クラスのリスト
          Expanded(
            child: Scrollbar(
              thickness: 10.0,
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                children: _selectedClass.keys
                    .map((item) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                              style: Fonts.h3,
                            ),
                          ),
                          value: _selectedClass[item],
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedClass[item] = value ?? false;
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ))
                    .toList(),
              ),
            ),
          ),
          // 選択されたクラスを表示するボタン
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                List<String> selectedClasses = _getSelectedClasses();
                print('Selected Classes: $selectedClasses'); // 選択されたクラスをコンソールに表示
                Navigator.pop(context); // ドロワーを閉じる
              },
              child: Text('選択されたクラスを表示'),
            ),
          ),
        ],
      ),
    );
  }

  // フィルタボタンを作成するウィジェット
  Widget _buildFilterButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31.0, vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: isSelected ? checkIcon : null, // 選択状態に応じてチェックアイコンを表示
          ),
          SizedBox(width: 8),
          Expanded(
            child: ListTile(
              title: Text(
                title,
                style: Fonts.h3,
              ),
              onTap: onTap,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
