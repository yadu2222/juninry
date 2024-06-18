import './teaching_item_model.dart';

// こんなんつくっていいんかなというきもちがある
// きえるかも
class RegisterHomework {
  TeachingItem teachingItem;
  int? startPage;
  int? pageCount;

  RegisterHomework({
    required this.teachingItem,
    this.startPage,
    this.pageCount,
  });
}
