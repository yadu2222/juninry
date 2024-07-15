import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/organism/submittion_list.dart';
import '../../components/molecule/homework_card.dart';
import '../../components/molecule/divider.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/template/basic_template.dart';
// model
import '../../../models/homework_model.dart';
// api
import '../../../apis/controller/homework_req.dart';
// image
import 'package:image_picker/image_picker.dart';  // カメラ用ライブラリ
import 'dart:io'; // ファイル操作用ライブラリ
// sample
import '../../../constant/sample_data.dart';

// 提出ページ
class PageSubmissionJunior extends HookWidget {
  final String homeworkUUID;
  const PageSubmissionJunior({
    super.key,
    required this.homeworkUUID,
  });

  final String title = '提出';

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker(); // カメラインスタンス
    final HomeworkReq homeworkReq = HomeworkReq(context: context); // APIコントローラー
    final homework = useState<Homework>(SampleData.homeworkData[1]); // 課題データ
    final images = useState<List<File?>>(List.filled(homework.value.pageCount, null)); // 画像配列 countの枚数を要素数にnullで初期化
    final counter = useState<int>(homework.value.pageCount); //  画像の枚数をカウント

    // 撮影処理
    Future<void> pickImage(int index) async {
      XFile? pickedFile = await picker.pickImage(source: ImageSource.camera); // カメラ起動
      // 一時ファイルにデータが有れば
      // 画像が既にある場合、つまり撮り直しを除外
      if (pickedFile != null) {
        if (images.value[index] == null) {
          counter.value--;
        }
        images.value[index] = (File(pickedFile.path)); // 画像用配列に保存
      }
    }
    // 撮影カウンター
    bool isCounter() {
      if (counter.value == 0) {
        return true;
      } else {
        return false;
      }
    }

    // 初回起動時に実行
    useEffect(() {
      // TODO:homework!!!!!!!!!!!!!!!!取得!!!!!!!!!!!!!!!!!!!!!!!!!
      // TODO: ここでIDを元に提出が必要な課題データを取得する処理を追加
      Future<void> fetchData() async {}
      fetchData();
      return () {};
    }, []);

    // 提出処理
    void submit() {
      // nullが含まれてないかな〜〜？を一応チェック
      bool isSubmit = true;
      for (int i = 0; i < images.value.length; i++) {
        if (images.value[i] == null) {
          // 画像がない場合はスキップ
          isSubmit = false;
        }
      }
      if (isSubmit) {
        // nullを絶対に除去するぞのきもち
        List<File> nonNullImages = images.value.where((file) => file != null).cast<File>().toList();
        // submittionHomework メソッドに渡す
        // TODO:提出確認 特定のHOMEWORKを取得できるようになったら変更する
        // homeworkReq.submittionHomework(homeworkUUID, nonNullImages);
        homeworkReq.submittionHomework("a3579e71-3be5-4b4d-a0df-1f05859a7103", nonNullImages);
      }
    }

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      HomeworkCard(homeworkData: SampleData.homeworkData[0]), // 課題カード
      const DividerView(), // 区切り線
      // 提出リスト
      Expanded(
          child: SubmittionList(
        homeworkData: homework.value,
        images: images.value,
        pickImage: pickImage,
      )), // 提出リスト
      
      // 状態を元に提出ボタンを呼び出し
      isCounter()
          ? BasicButton(
              text: "提出",
              onPressed: () {
                submit();
              },
              isColor: true,
            )
          : BasicButton(text: "あと${counter.value.toString()}枚", isColor: false, onPressed: () {})
    ]);
  }
}
