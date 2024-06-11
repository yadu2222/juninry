class Homework {
  String homeworkUuid;
  String homeworkLimit;           // TODO:dateにすべきでは？
  String teachingMaterialUuid;
  int startPage;
  int pageCount;
  String homeworkPosterUuid;
  String homeworkNote;
  String teachingMaterialName;
  int subjectId;
  String imageUuid;
  String classUuid;
  int submitFlg;

  // 課題ID	task_uuid
  // 期限	task_limit
  // 教材ID	teaching_material_uuid
  // 開始ページ	start_page
  // ページ枚数	page_count
  // 投稿者ID	task_poster_uuid
  // 説明	task_note
  // 教材ID	teaching_material_uuid
  // 教材名	teaching_material_name
  // 教科ID	subject_id
  // 画像ID	image_uuid
  // クラスID	class_uuid
  // 提出済みかどうか	submit_flg

  Homework({
    required this.homeworkUuid,
    required this.homeworkLimit,
    required this.teachingMaterialUuid,
    required this.startPage,
    required this.pageCount,
    required this.homeworkPosterUuid,
    required this.homeworkNote,
    required this.teachingMaterialName,
    required this.subjectId,
    required this.imageUuid,
    required this.classUuid,
    required this.submitFlg,
  });

}
