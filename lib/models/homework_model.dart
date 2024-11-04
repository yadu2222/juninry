import 'package:flutter/material.dart';
import './teaching_item_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Homework {
  String? homeworkUUID;
  DateTime? homeworkLimit; // TODO:dateにすべきでは？
  int startPage;
  int pageCount;
  String? homeworkPosterUuid;
  String homeworkNote;
  String? imageUuid;
  String className;
  int? submitFlg;
  TeachingItem teachingItem;
  List<String>? imageUrls;

  Homework({
    this.homeworkUUID,
    this.homeworkLimit,
    required this.startPage,
    required this.pageCount,
    this.homeworkPosterUuid,
    required this.homeworkNote,
    this.imageUuid,
    required this.className,
    this.submitFlg,
    required this.teachingItem,
    this.imageUrls
  });

  static Homework errHomework = Homework(
    homeworkUUID: '',
    homeworkLimit: DateTime.now(),
    startPage: 0,
    pageCount: 0,
    homeworkPosterUuid: '',
    homeworkNote: '',
    imageUuid: '',
    className: '',
    submitFlg: 0,
    teachingItem: TeachingItem(
      teachingMaterialUUID: '',
      teachingMaterialName: '',
      subjectId: 0,
    ),
  );

  static Homework resToHomework(http.Response response) {


    // jsonデータに変換
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    Map resData = json['srvResData'];

    try {
      return Homework(
        startPage: resData['startPage'],
        pageCount: resData['pageCount'],
        homeworkNote: resData['homeworkNote'] ?? '',
        className: resData['className'] ?? '',
        teachingItem: TeachingItem(
          teachingMaterialUUID: resData['teachingMaterialUUID'],
          teachingMaterialName: resData['teachingMaterialName'],
          subjectId: resData['subjectId'],
        ),
        submitFlg: resData['submitStatus'],
        imageUrls: (resData['images'] != null) ? resData['images'].split(', ').toList() : [],
      );
    } catch (e) {
      print('Error converting resData to Homework: $e');
      return errHomework;
    }
  }

  // 失敗したらサービスでエラーを返す
  // のでここでは特に対応しない
  // keyで指定した値をmapの頭に配置(つたわれ)
  // datetime変換が必要なものをkeyのvalueにしたければtimeをtrueに指定 きたないね
  // このかたちになる
  // [
  //   {
  //     'key': 'value',
  //     'homeworkData': []
  //   },
  //]
  // 型が安全じゃなさすぎるだろという怒り
  static List<dynamic> resToHomeworks(http.Response response, String? key, [bool time = false]) {


    // jsonに変換
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    List resData = json['srvResData'] ?? [];

    List<dynamic> homeworks = [];
    // リストをmapに変換
    try {
      if (key != null) {
        for (Map loadItem in resData) {
          Map<String, dynamic> addHomeworks = {}; // 追加用のmapを作成 型指定でエラー回避
          // 変換してほしいのかチェック
          if (time) {
            addHomeworks[key] = DateTime.parse(loadItem[key]); // mapにkeyを追加
          } else {
            addHomeworks[key] = loadItem[key]; // mapにkeyを追加
          }

          //       "srvResMsg": "OK",
          // "srvResData": [
          //   {
          //     "homeworkLimit": "0001-01-01T00:00:00Z",
          //     "homeworkData": [
          //       {
          //         "homeworkUUID": "a3579e71-3be5-4b4d-a0df-1f05859a7104",
          //         "startPage": 24,
          //         "pageCount": 2,
          //         "homeworkNote": "がんばってくださ～い＾＾",
          //         "teachingMaterialName": "漢字ドリル3",
          //         "subjectId": 1,
          //         "subjectName": "国語",
          //         "teachingMaterialImageUUID": "a575f18c-d639-4b6d-ad57-a9d7a7f84575",
          //         "className": "3-2 ふたば学級",
          //         "submitFlag": 1  // 提出フラグ 1 提出 0 未提出
          //       },,,
          //     ]
          //   },,,
          // ]
          addHomeworks['homeworkData'] = []; // mapに空リストを追加
          // データをHomeworkに変換してリストに追加
          for (Map loadHomework in loadItem['homeworkData']) {
            Homework homework = Homework(
              homeworkUUID: loadHomework['homeworkUUID'],
              startPage: loadHomework['startPage'],
              pageCount: loadHomework['pageCount'],
              homeworkNote: loadHomework['homeworkNote'],
              className: loadHomework['className'],
              submitFlg: loadHomework['submitStatus'],
              teachingItem: TeachingItem(
                teachingMaterialUUID: loadHomework['teachingMaterialImageUUID'], // 教材そのもののUUIDはこないらしいぞ！(そうなの！！？)
                teachingMaterialName: loadHomework['teachingMaterialName'],
                subjectId: loadHomework['subjectId'],
              ),
            );
            // 先ほど追加した空リストに宿題を追加
            addHomeworks['homeworkData'].add(homework);
            // print(homework.toString());
          }
          homeworks.add(addHomeworks);
        }
      } else {
        // 一つのリストにまとめる
        for (Map loadItem in resData) {
          for (Map loadHomework in loadItem['homeworkData']) {
            Homework homework = Homework(
              homeworkUUID: loadHomework['homeworkUUID'],
              startPage: loadHomework['startPage'],
              pageCount: loadHomework['pageCount'],
              homeworkNote: loadHomework['homeworkNote'],
              submitFlg: loadHomework['submitStatus'],
              className: loadHomework['className'],
              teachingItem: TeachingItem(
                teachingMaterialUUID: loadHomework['teachingMaterialImageUUID'],
                teachingMaterialName: loadHomework['teachingMaterialName'],
                subjectId: loadHomework['subjectId'],
              ),
            );
            homeworks.add(homework);
          }
        }
      }
      return homeworks;
    } catch (e) {
      debugPrint('Error converting resData to Homeworks: $e');
      return [];
    }
  }

  // mapをHomeworkに変換
  static Homework dBtoHomework(Map loadData) {
    try {
      return Homework(
        homeworkUUID: loadData['homework_id'].toString(),
        homeworkLimit: DateTime.parse(loadData['homework_limit']),
        startPage: loadData['start_page'],
        pageCount: loadData['page_count'],
        homeworkPosterUuid: loadData['homework_poster_uuid'],
        homeworkNote: loadData['homework_note'],
        className: loadData['class_uuid'],
        teachingItem: TeachingItem(
          teachingMaterialUUID: loadData['teaching_material_uuid'],
          teachingMaterialName: loadData['teaching_material_name'],
          subjectId: loadData['subject_id'],
        ),
      );
    } catch (e) {
      print('Error converting map to Homework: $e');
      return errHomework;
    }
  }
}
