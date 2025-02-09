import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; // MIMEタイプを推測するためのパッケージ
import 'package:http_parser/http_parser.dart'; // ファイルのアップロードに必要
import 'dart:convert';
import '../models/req_model.dart';
import '../models/user_model.dart';
import '../constant/urls.dart';
import 'dart:io';

class HttpReq {
  static Future<http.Response> httpReq(Request reqData, [bool isAuth = true]) async {
    if (isAuth) {
      User user = await User.getUser(); // user情報をdbから取得
      reqData.headers['Authorization'] = user.jwtKey!; // ヘッダーに認証トークンを追加
    }
    String url = Urls.baseUrl + reqData.url; // urlを生成
    // パラメータがあればurlと合成
    if (reqData.pasParams != null) {
      url += "/${reqData.pasParams}";
    }

    Uri uri = Uri.parse(url);

    // クエリパラメータの処理
    if (reqData.queryParams != null) {
      uri = uri.replace(queryParameters: reqData.queryParams);
    }

    http.Response response = http.Response('{}', 500); // 初期値を設定（例: 空のレスポンス）;
    // リクエストの種類によって処理を分岐
    switch (reqData.reqType) {
      case 'GET':
        response = await http.get(
          uri,
          headers: reqData.headers,
        );
        break;
      case 'POST':
        response = await http.post(uri, headers: reqData.headers, body: jsonEncode(reqData.body));
        break;
      case 'PUT':
        response = await http.put(uri, headers: reqData.headers, body: jsonEncode(reqData.body));
        break;
      case 'MULTIPART':
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll(reqData.headers);

        // nullチェック
        if (reqData.body != null) {
          reqData.body!.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }
        // ファイルを追加
        if (reqData.files != null) {
          for (File file in reqData.files!) {
            String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
            request.files.add(
              await http.MultipartFile.fromPath(
                'images',
                file.path,
                contentType: MediaType.parse(mimeType),
              ),
            );
          }
        }
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        break;
      // case 'DELETE':
      //   response = await http.delete(Uri.parse(url), headers: reqData.headers);
      //   break;
    }
    // レスポンスの処理
    debugPrint(response.body.toString());
    // 成功
    // if (response.statusCode < 300) {
    //   return jsonDecode(response.body) as Map<String, dynamic>;
    //   // 失敗時の処理
    // } else {
    //   reqData.errorHandling(response);
    //   return {};
    // }
    return response;
  }

  // mapでかえしてはいけない型でつかう
  static Future<http.Response> imagesReq(Request reqData, [bool isAuth = true]) async {
    if (isAuth) {
      User user = await User.getUser(); // user情報をdbから取得
      reqData.headers['Authorization'] = user.jwtKey!; // ヘッダーに認証トークンを追加
    }
    String url = Urls.baseUrl + reqData.url; // urlを生成
    // パラメータがあればurlと合成
    if (reqData.pasParams != null) {
      url += "/${reqData.pasParams}";
    }

    Uri uri = Uri.parse(url);

    // クエリパラメータの処理
    if (reqData.queryParams != null) {
      uri = uri.replace(queryParameters: reqData.queryParams);
    }

    http.Response response = http.Response('{}', 500); // 初期値を設定（例: 空のレスポンス）;
    // リクエストの種類によって処理を分岐
    switch (reqData.reqType) {
      case 'GET':
        response = await http.get(
          uri,
          headers: reqData.headers,
        );
        break;
      case 'POST':
        response = await http.post(uri, headers: reqData.headers, body: jsonEncode(reqData.body));
        break;
      case 'PUT':
        response = await http.put(uri, headers: reqData.headers, body: jsonEncode(reqData.body));
        break;
      case 'MULTIPART':
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll(reqData.headers);

        // nullチェック
        if (reqData.body != null) {
          reqData.body!.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }
        // ファイルを追加
        if (reqData.files != null) {
          for (File file in reqData.files!) {
            String mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
            request.files.add(
              await http.MultipartFile.fromPath(
                'images',
                file.path,
                contentType: MediaType.parse(mimeType),
              ),
            );
          }
        }
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        break;
      // case 'DELETE':
      //   response = await http.delete(Uri.parse(url), headers: reqData.headers);
      //   break;
    }

    // 成功
    if (response.statusCode < 300) {
      return response;
      // 失敗時の処理
    } else {
      return reqData.errorHandling(response);
    }
  }
}
