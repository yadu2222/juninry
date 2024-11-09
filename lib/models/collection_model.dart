import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Collection {
  final int collectionID;
  final String collectionUUID;
  final String imgPath;
  final File? image;
  final String name;
  final String description;
  final String talk;
  final bool hasItem;
  final int quantity;

  Collection(
      {required this.collectionID,
      required this.collectionUUID,
      required this.imgPath,
      required this.image,
      required this.name,
      required this.description,
      required this.talk,
      required this.hasItem,
      this.quantity = 0});

  static resItemToCollections(http.Response response) {
    Map json = jsonDecode(response.body) as Map<String, dynamic>;
    List loadData = json['srvResData'] as List<dynamic>;

    List<Collection> collections = [];
    try {
      for (Map loadItem in loadData) {
        collections.add(Collection(
            collectionID: loadItem['itemNumber'],
            collectionUUID: loadItem['itemName'],
            imgPath: loadItem['imagePath'],
            image: null,
            name: loadItem['itemName'],
            description: loadItem['detail'],
            talk: loadItem['talk'],
            hasItem: loadItem['hasItem'],
            quantity: loadItem['quantity']));
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
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
  ];

  static List<Collection> nyariotCollection = [
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "item/IMG_0071.PNG", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
  ];

  static List<Collection> itemCollection = [
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
    Collection(collectionID: 1, collectionUUID: "adsjkaf", imgPath: "", image: null, name: "name", description: "ddd", talk: "", hasItem: false),
  ];
}
