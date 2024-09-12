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
import 'package:image_picker/image_picker.dart'; // カメラ用ライブラリ
import 'dart:io'; // ファイル操作用ライブラリ
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// sample
// import '../../../constant/sample_data.dart';

// 提出ページ
class PageSubmissionJunior extends HookWidget {
  final String homeworkUUID;
  final Homework homework;
  const PageSubmissionJunior({super.key, required this.homeworkUUID, required this.homework});

  final String title = '提出';

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker(); // カメラインスタンス
    final HomeworkReq homeworkReq = HomeworkReq(context: context); // APIコントローラー
    final homeworkData = useState<Homework?>(null); // 課題データ
    final images = useState<List<File?>>([]); // 画像配列 countの枚数を要素数にnullで初期化
    final counter = useState<int>(0); //  画像の枚数をカウント
    final submittionFlag = useState<bool>(false); // 提出フラグ

    // 課題の情報と提出状況を取得
    Future<void> getHomework() async {
      final loadHomeworkData = await homeworkReq.getHomeworkHandler(homeworkUUID);

      if (loadHomeworkData == null) {
        homeworkData.value = homework;
      } else {
        homeworkData.value = loadHomeworkData;
      }
    }

    Future<File> saveImage(File image) async {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = join(directory.path, basename(image.path));
      return image.copy(imagePath);
    }

    // 撮影処理
    Future<void> pickImage(int index) async {
      XFile? pickedFile = await picker.pickImage(source: ImageSource.camera); // カメラ起動
      // 一時ファイルにデータが有れば
      // 画像が既にある場合、つまり撮り直しを除外
      if (pickedFile != null) {
        if (images.value[index] == null) {
          counter.value--;
        }
        // 永続ストレージに画像を保存
        File savedImage = await saveImage(File(pickedFile.path));
        images.value[index] = savedImage; // 画像用配列に保存
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
      Future<void> fetchData() async {
        await getHomework();
        // 画像に関する変数を初期化
        submittionFlag.value = homeworkData.value!.submitFlg == 1;
        if (submittionFlag.value) {
          // 画像パスから画像を取得
          for (String imageFileName in homeworkData.value!.imageUrls!) {

            final image = await homeworkReq.getHomeworkImage(homeworkUUID, imageFileName);
            // 新しいリストを作成して更新
            images.value = [...images.value, image];
          }
        } else {
          images.value = homeworkData.value!.pageCount != 0 ? List.filled(homeworkData.value!.pageCount, null) : List.filled(homeworkData.value!.startPage, null);
          counter.value = homeworkData.value!.pageCount;
        }
      }

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
        homeworkReq.submittionHomework(homeworkUUID, nonNullImages);
      }
    }

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      homeworkData.value == null ? const SizedBox.shrink() : HomeworkCard.junior(homeworkData: homeworkData.value!), // 課題カード
      const DividerView(), // 区切り線
      // 提出リスト
      homeworkData.value == null
          ? const SizedBox.shrink()
          : Expanded(
              child: SubmittionList(
              homeworkData: homeworkData.value!,
              images: images.value,
              pickImage: pickImage,
            )), // 提出リスト

      // 状態を元に提出ボタンを呼び出し
      submittionFlag.value
          ? BasicButton(text: "提出済です", onPressed: () {}, isColor: true)
          : isCounter()
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
