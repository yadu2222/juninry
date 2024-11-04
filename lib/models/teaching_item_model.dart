import 'dart:convert';
import 'package:http/http.dart' as http;

class TeachingItem {
  String? teachingMaterialUUID;
  String teachingMaterialName;
  int subjectId;

  TeachingItem({
    this.teachingMaterialUUID,
    required this.teachingMaterialName,
     required this.subjectId,
  });

  // レスポンスデータをTeachingItemに変換
  static List<TeachingItem> resToTeachingItem(http.Response response) {

    // jsonに変換
    Map resData = jsonDecode(response.body) as Map<String, dynamic>;
    List<TeachingItem> teachingItems = [];
   
    for (Map loadData in resData['srvResData']['teachingItems']) {
      teachingItems.add(TeachingItem(
        teachingMaterialUUID: loadData['teachingMaterialUUID'],
        teachingMaterialName: loadData['teachingMaterialName'],
        subjectId: loadData['subjectID'],
      ));
    }
    return teachingItems;
  }
}
