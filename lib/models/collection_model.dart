import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Collection {
  final int collectionID;
  final String collectionUUID;
  final String imgPath;
  final String name;
  final String description;
  final String talk;
  final bool hasItem;
  final int quantity;
  final int rarity;

  Collection(
      {required this.collectionID,
      required this.collectionUUID,
      required this.imgPath,
      required this.name,
      required this.description,
      required this.talk,
      required this.hasItem,
      this.quantity = 0,
      required this.rarity});

  static List<Collection> resToGatyaResults(http.Response response) {
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    List loadData = json['srvResData'] as List<dynamic>;

    List<Collection> collections = [];
    try {
      for (Map loadItem in loadData) {
        if (loadItem['rarity'] < 4) {
          debugPrint("aaaaa");
          // アイテム
          collections.add(Collection(
              collectionID: loadItem['itemNumber'],
              collectionUUID: loadItem['itemUUID'],
              imgPath: loadItem['imagePath'],
              name: loadItem['itemName'],
              description: loadItem['detail'],
              talk: loadItem['talk'],
              hasItem: loadItem['hasItem'],
              quantity: loadItem['quantity'] ?? 0,
              rarity: loadItem['rarity']));
        } else {
          // ニャリオット
          collections.add(Collection(
              collectionID: loadItem['itemNumber'],
              collectionUUID: loadItem['itemUUID'],
              imgPath: loadItem['imagePath'],
              name: loadItem['itemName'],
              description: loadItem['detail'],
              talk: loadItem['talk'],
              hasItem: loadItem['hasItem'],
              quantity: loadItem['quantity'] ?? 0,
              rarity: loadItem['rarity']));
        }
      }
    } catch (e) {
      print(e);
    }
    return collections;
  }

  static List<Collection> resItemToCollections(http.Response response) {
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    List loadData = json['srvResData'] as List<dynamic>;
    List<Collection> collections = [];
    try {
      for (Map loadItem in loadData) {
        collections.add(Collection(
            collectionID: loadItem['itemNumber'],
            collectionUUID: loadItem['itemName'],
            imgPath: loadItem['imagePath'],
            name: loadItem['itemName'],
            description: loadItem['detail'],
            talk: loadItem['talk'],
            hasItem: loadItem['hasItem'],
            quantity: loadItem['quantity'] ?? 0,
            rarity: loadItem['rarity']));
      }
    } catch (e) {
      print(e);
    }
    return collections;
  }

//   // 図鑑用所持、未所持を保持する変数があるテーブル(ニャリオット編)
// type NyariotCatalog struct {
//     NyariotUuid      string `json:"nyariotUUID"`      // ニャリオットUUID
//     NyariotName      string `json:"nyariotName"`      // ニャリオット名
//     NyariotImagePath string `json:"nyariotImagePath"` // ニャリオット画像パス
//     Nyarindex        int    `json:"nyarindex"`        // ニャリオット番号
//     Detail           string `json:"detail"`           // ニャリオット詳細
//     Talk             string `json:"talk"`             // ニャリオット固有の会話
//     Rarity           int    `json:"rarity"`           // レアリティ 4:SSR
//     HasItem          bool   `json:"hasItem"`          // 所持、未所持
//     ConvexNumber     int    `json:"convexNumber"`     //所持数
// }

//  "srvResData": [
//     {
//       "itemUUID": "4b52cf51-583e-4390-9f5c-5b7dbdfd65ef",
//       "itemName": "あああああああ",
//       "imagePath": "item/IMG_3.PNG",
//       "itemNumber": 6,
//       "detail": "いいいいい",
//       "talk": "ううううううう",
//       "rarity": 1,
//       "hasItem": false
//     }
//   ],

  static Collection resNyariotToCollction(http.Response response) {
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    Map loadItem = json['srvResData'] as Map;

    return Collection(
      collectionID: loadItem['nyarindex'],
      collectionUUID: loadItem['nyariotUUID'],
      imgPath: loadItem['nyariotImagePath'],
      name: loadItem['nyariotName'],
      description: loadItem['detail'],
      talk: loadItem['talk'],
      hasItem: loadItem['hasItem'],
      quantity: loadItem['convexNumber'],
      rarity: loadItem['rarity'],
    );
  }

  static List<Collection> resNyariotToCollections(http.Response response) {
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    List loadData = json['srvResData'] as List<dynamic>;

    List<Collection> collections = [];
    try {
      for (Map loadItem in loadData) {
        collections.add(Collection(
            collectionID: loadItem['nyarindex'],
            collectionUUID: loadItem['nyariotUUID'],
            imgPath: loadItem['nyariotImagePath'],
            name: loadItem['nyariotName'],
            description: loadItem['detail'],
            talk: loadItem['talk'],
            hasItem: loadItem['hasItem'],
            quantity: loadItem['convexNumber'],
            rarity: loadItem['rarity']));
      }
    } catch (e) {
      print(e);
    }
    return collections;
  }

  // "srvResData": [
  // {
  //   "itemUUID": "563c5110-3441-4cb0-9764-f32c4385e975",
  //   "itemName": "おさかな",
  //   "imagePath": "asset/images/item/IMG_0071.PNG",
  //   "itemNumber": 1,
  //   "detail": "ちからもスピードもほとんどダメ",
  //   "talk": "遥か大昔はそれなりに強かったみたい",
  //   "satityDegrees": 10,
  //   "rarity": 1,
  //   "hasItem": false,
  //   "quantity": 0
  // },
  // {
  //   "itemUUID": "bf24b47d-a71b-4175-b5f1-fc622e5c5ac5",
  //   "itemName": "おいしいみず",
  //   "imagePath": "asset/images/item/water.PNG",
  //   "itemNumber": 2,
  //   "detail": "ミネラルたっぷりのみず",
  //   "talk": "しれんサポーターに渡すとビビリだまが貰えるよ",
  //   "satityDegrees": 20,
  //   "rarity": 2,
  //   "hasItem": false,
  //   "quantity": 0
  // },

  static List<Collection> testCollection = [
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
  ];

  static List<Collection> nyariotCollection = [
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
  ];

  static List<Collection> itemCollection = [
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", name: "name", description: "ddd", talk: "", hasItem: false, rarity: 1),
  ];

  static Collection errorCollection = Collection(
      collectionID: 0,
      collectionUUID: "",
      imgPath: "",
      name: "",
      description: "",
      talk: "",
      hasItem: false,
      rarity: 0);
}
