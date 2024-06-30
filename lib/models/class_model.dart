import 'package:flutter/material.dart';

class Class {
  String classUuid;
  String className;

  // クラスID class_uuid
  // クラス名 class_name

  Class({
    required this.classUuid,
    required this.className,
  });

  static Class errorClass() {
    return Class(classUuid: '', className: '');
  }

  static Class resToClass(Map resData) {
    try {
      return Class(
        classUuid: resData['srvResData']['classUuid'],
        className: resData['srvResData']['className'],
      );
    } catch (e) {
      debugPrint('Error converting map to Class: $e');
      return Class.errorClass();
    }
  }
}
