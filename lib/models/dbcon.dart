import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper(); // 無名のコンストラクタを追加

  static const _databaseName = "MyDatabase.db"; // DB名
  static const _databaseVersion = 1; // スキーマのバージョン指定

  // DatabaseHelper クラスを定義
  DatabaseHelper._privateConstructor();
  // DatabaseHelper._privateConstructor() コンストラクタを使用して生成されたインスタンスを返すように定義
  // DatabaseHelper クラスのインスタンスは、常に同じものであるという保証
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Databaseクラス型のstatic変数_databaseを宣言
  // クラスはインスタンス化しない
  static Database? _database;

  // databaseメソッド定義
  // 非同期処理
  Future<Database?> get database async {
    // _databaseがNULLか判定
    // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
    // NULLでない場合、そのまま_database変数を返す
    // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになる。
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // データベース接続
  _initDatabase() async {
    debugPrint("とおった?");
    // アプリケーションのドキュメントディレクトリのパスを取得
    final dbDirectory = await getApplicationSupportDirectory();
    // 取得パスを基に、データベースのパスを生成
    final path = join(dbDirectory.path, _databaseName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate);
  }

  // テーブル作成
  // 引数:dbの名前
  // 引数:スキーマーのversion
  // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
  Future<void> _onCreate(Database db, int version) async {
    // ユーザーのアカウントを管理するためのテーブル
    // ログイン情報的なね
    await db.execute('''
    CREATE TABLE users (
      user_id integer PRIMARY KEY autoincrement,
      user_uuid text,
      user_type_id integer,
      mail_address  text,
      password text,
      jti_uuid text,
      jwt_key text
    )
  ''');

    // 宿題の下書きを保存するためのテーブル
    await db.execute('''
    CREATE TABLE homeworkDrafts (
      homework_id integer PRIMARY KEY autoincrement,
      homework_limit text not null,
      start_page integer not null,
      page_count integer not null,
      homework_poster_uuid text not null,
      homework_note text,
      class_uuid text not null,
      teaching_material_uuid text not null,
      teaching_material_name text not null,
      subject_id integer not null
    )
  ''');

    // お知らせの下書きを管理するためのテーブル
    // このテーブル構造に関して、私は真に驚くべききもさを見つけたが、この余白はそれを書くには狭すぎる。

    await db.execute('''
    CREATE TABLE drafted_notices (
      notice_id integer PRIMARY KEY autoincrement,
      notice_title text,
      notice_explanatory text,
      class_uuid text,
      class_name text,
      quoted_notice_uuid text,
      FOREIGN KEY (quoted_notice_uuid) REFERENCES quoted_notices(quoted_notice_uuid)
    )
  ''');
  }

  // 登録処理
  // 引数：table名、追加するmap
  static Future<int> insert(String tableName, Map<String, dynamic> row) async {
    debugPrint("insert");
    Database? db = await instance.database;
    return await db!.insert(tableName, row);
  }

  // 照会処理
  // 引数：table名
  static Future<List<Map<String, dynamic>>> queryAllRows(
      String tableName) async {
    Database? db = await instance.database;
    // print(await db!.rawQuery("select * from $tableName"));
    return await db!.rawQuery("select * from $tableName");
  }

  // テーブル名、検索条件、検索ワード、ソート
  static Future<List<Map<String, dynamic>>> queryBuilder(String tableName,
      List<String> where, List<String> whereArgs, String orderBy) async {
    Database? db = await instance.database;
    return await db!.query(
      tableName,
      where: where.join(' = ? AND ') + ' = ?',
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  static Future<bool> firstdb() async {
    Database? db = await instance.database;
    List result = await db!.rawQuery("select * from users");
    // 取得した結果が空でないかを確認し、存在する場合はtrueを、存在しない場合はfalseを返す
    return result.isNotEmpty;
  }

  // 更新処理
  // 引数：table名、更新後のmap、検索キー
  static Future<int> update(String tableName, String colum,
      Map<String, dynamic> row, String key) async {
    Database? db = await instance.database;
    return await db!
        .update(tableName, row, where: '$colum = ?', whereArgs: ['$key']);
  }

  // 削除処理
  // 引数：table名、更新後のmap、検索キー
  static Future<int> delete(String tableName, String colum, String key) async {
    Database? db = await instance.database;
    return await db!.delete(tableName, where: '$colum = ?', whereArgs: [key]);
  }

  // TODO:クエリビルダーがうごくまでのしょち
  // くやしいね
  static Future<List<Map<String, dynamic>>> getHomeworksForSpecificDate(
      String date) async {
    Database? db = await instance.database;

    // クエリの実行
    List<Map<String, dynamic>> result = await db!.rawQuery(
      '''
    SELECT * FROM homeworks
    WHERE DATE(homework_limit) = DATE(?)
    ''',
      [date],
    );

    return result;
  }

  // レコードに存在するか確認
  // 引数：table名、検索キー
  static Future<bool> queryExists(
      String tableName, String colum, String key) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result =
        await db!.query(tableName, where: '$colum = ?', whereArgs: [key]);
    // 取得した結果が空でないかを確認し、存在する場合はtrueを、存在しない場合はfalseを返す
    return result.isNotEmpty;
  }

  // レコードから一行取得
  // 引数：table名、属性名、検索キー
  static Future<Map<String, dynamic>> queryRow(
      String tableName, String colum, String key) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result =
        await db!.query(tableName, where: '$colum = ?', whereArgs: [key]);
    return result[0];
  }
}
