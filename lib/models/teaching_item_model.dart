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
  static List<TeachingItem> resToTeachingItem(Map resData) {
    List<TeachingItem> teachingItems = [];

    for (Map loadData in resData['teachingItems']) {
      teachingItems.add(TeachingItem(
        teachingMaterialUUID: loadData['teachingMaterialUUID'],
        teachingMaterialName: loadData['teachingMaterialName'],
        subjectId: loadData['subjectID'],
      ));
    }
    return teachingItems;
  }
}
