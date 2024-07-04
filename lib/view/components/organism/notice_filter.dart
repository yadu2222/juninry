import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:juninry/constant/colors.dart';
import '../../../constant/fonts.dart';
import '../../../constant/sample_data.dart'; // サンプルデータのインポート

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  // ボタンの選択状態を保持する変数
  bool _isConfirmedSelected = false;
  bool _isUnconfirmedSelected = false;
  bool _selectAll = false;
  Map<String, bool> _selectedClass = {};
  ScrollController _scrollController = ScrollController();

  // チェックアイコンの定義
  final Icon checkIcon = const Icon(
    Icons.check,
    color: AppColors.iconDark,
    size: 24,
  );

  @override
  void initState() {
    super.initState();
    // SampleData.noticesDataの各Noticeのクラス名をキーとして、選択状態を初期化
    for (var notice in SampleData.noticesData) {
      _selectedClass[notice.className] = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      _selectedClass.updateAll((key, value) => _selectAll);
    });
  }

  List<String> _getSelectedClasses() {
    return _selectedClass.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          // ヘッダー部分
          Container(
            height: 100, // ヘッダーの高さを調整
            decoration: BoxDecoration(
              color: AppColors.main, // ヘッダーの背景色
            ),
            alignment: Alignment.centerLeft, // テキストを左寄せ
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // 左右のパディングを追加
            child: Text(
              '絞り込み', // ヘッダーのタイトル
              style: Fonts.h2w,
            ),
          ),
          // フィルターオプション部分
          Padding(
            padding: const EdgeInsets.all(5.0), // パディングを追加
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // フィルターボタン
                _buildFilterButton(
                  title: '未確認',
                  isSelected: _isUnconfirmedSelected,
                  onTap: () {
                    setState(() {
                      _isUnconfirmedSelected = !_isUnconfirmedSelected;
                      if (_isUnconfirmedSelected) {
                        _isConfirmedSelected = false; // もう一方を解除
                      }
                    });
                  },
                ),
                _buildFilterButton(
                  title: '確認済み',
                  isSelected: _isConfirmedSelected,
                  onTap: () {
                    setState(() {
                      _isConfirmedSelected = !_isConfirmedSelected;
                      if (_isConfirmedSelected) {
                        _isUnconfirmedSelected = false; // もう一方を解除
                      }
                    });
                  },
                ),
                _buildFilterButton(
                  title: _selectAll ? '全件解除' : '全件選択',
                  isSelected: _selectAll,
                  onTap: _toggleSelectAll,
                ),
                Divider(thickness: 3.0), // 太いラインを引く
              ],
            ),
          ),
          // スクロール可能なクラスのリスト
          Expanded(
            child: Scrollbar(
              thickness: 10.0, // スクロールバーの太さを設定
              thumbVisibility: true, // スクロールバーを常に表示
              controller: _scrollController, // スクロールコントローラを設定
              child: ListView(
                controller: _scrollController, // スクロールコントローラを設定
                padding: const EdgeInsets.all(16.0),
                children: _selectedClass.keys.map((item) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading, // チェックボックスを左側に配置
                  title: Padding(
                    padding: const EdgeInsets.only(left: 14.0), // 左パディングを設定
                    child: Text(
                      item, // チェックボックスのタイトル
                      overflow: TextOverflow.ellipsis, // テキストが長い場合に省略
                      style: Fonts.h3, // テキストのサイズ
                    ),
                  ),
                  value: _selectedClass[item], // チェックボックスの選択状態
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedClass[item] = value ?? false; // 状態を更新
                    });
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // パディングを設定
                )).toList(), // 各チェックボックスをリストとして表示
              ),
            ),
          ),

          // 選択されたクラスを表示するボタン
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                List<String> selectedClasses = _getSelectedClasses();
                print('Selected Classes: $selectedClasses'); // 選択されたクラスを表示
              },
              child: Text('選択されたクラスを表示'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({required String title, required bool isSelected, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31.0, vertical: 8.0), // チェックボックスと同じパディングを設定
      child: Row(
        children: [
          SizedBox(
            width: 24, // アイコンのサイズと同じ幅を確保
            height: 24,
            child: isSelected ? checkIcon : null,
          ),
          SizedBox(width: 8), // アイコンとテキストの間にスペースを追加
          Expanded(
            child: ListTile(
              title: Text(
                title, // タイトル
                style: Fonts.h3, // テキストのサイズ
              ),
              onTap: onTap,
              contentPadding: EdgeInsets.zero, // 内側のパディングを設定しない
            ),
          ),
        ],
      ),
    );
  }
}
