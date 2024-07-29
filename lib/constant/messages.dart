class Messages {
  // かくにん
  static const String confirmation = "かくにん";
  static const String confirmationMsg = "入力内容が消えてしまいます！\n下書きに保存しますか？";

  // 下書き
  static const String draft = "下書き";
  static const String draftDelete = "下書きを削除してよろしいですか？";
  static const String draftMsg = "下書きを保存しました\n一覧画面に戻ります";

  // 成功
  static const String draftRegisterSuccess = "下書きの保存に成功しました！";
  static const String registerSuccess = "登録に成功しました";
  static const String loginSuccess = "ログインに成功しました";
  static const String joinClassSuccess = 'に参加しました！'; // 参加成功
  static const String createClassSuccess = 'を作成しました！'; // 作成成功
  static const String submittionHomeworkSuccess = '宿題を提出しました！'; // 提出成功
  static const String postNoticeSuccess = 'お知らせを投稿しました！\n一覧画面に戻ります'; // 投稿成功
  static const String createSuccess = '作成に成功しました！'; // 生成成功
  static const String destionHelpSuccess = 'おてつだいを報告しました！'; // 生成成功

  // APIエラー
  static const String defaultError = "通信に失敗しました"; // データベースエラー
  static const String permittonError = "権限がありません"; // 権限エラー
  static const String inputError = "入力内容が不足しています"; // 入力エラー
  static const String loginError = "ログインに失敗しました"; // ログインエラー
  static const String registerError = "登録に失敗しました"; // 登録エラー
  static const String getUserError = "ユーザー情報の取得に失敗しました"; // 取得エラー
  static const String getHomeworkError = "宿題の取得に失敗しました"; // 取得エラー
  static const String getClassmates = "クラスメイトの取得に失敗しました"; // 取得エラー
  static const String getClasses = "クラス一覧の取得に失敗しました"; // 取得エラー
  static const String joinClassError = "クラス参加に失敗しました"; // 参加エラー
  static const String joinClassConflictError = "すでに参加しています！"; // 参加エラー1
  static const String inviteClassError = "招待コードの発行に失敗しました"; // 参加エラー
  static const String createClassError = 'クラス作成に失敗しました'; // 生成失敗
  static const String createOuchiError = 'クラス作成に失敗しました'; // 生成失敗

  static const String submittionHomeworkError = '宿題の提出に失敗しました'; // 生成失敗
  static const String postNoticeError = 'お知らせの投稿に失敗しました'; // 生成失敗

  static const String getHelpError = 'おてつだいの取得に失敗しました'; // 生成失敗
  static const String destionHelpError = 'おてつだいの報告に失敗しました'; // 生成失敗

  // 警告
  static const String pointShortage = "ポイントが不足しています"; // ポイント不足

  // 通信エラー
  static const String databaseError = "ごめんなさい";
  static const String databaseErrorMsg = "保存に失敗しました\n再度実行してください";

  // 空だねというとき
  static const String homeworkIsEmpty = "宿題はありません"; // 取得エラー
  static const String noticeTitleIsEmpty = "タイトルを入力してください";
  static const String isEmpty = "データが見つかりません";
}
