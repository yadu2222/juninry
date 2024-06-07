import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({
    Key? key,
  }) : super(key: key);

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage> {
  late CameraController _controller; // カメラのコントローラー
  final _cameraLoaded = Completer<bool>(); // カメラの初期化が完了したかどうかを格納するCompleter
  var _isZooming = false; // ズーム中かどうか
  var _isTakingPicture = false; // 撮影中かどうか

  File? _imageFile; // 撮影されたファイルを格納する変数


  @override
  void initState() {
    super.initState();

    // 利用可能なカメラの取得
    availableCameras().then((cameras) {
      // 最初のカメラでコントローラーを初期化
      _controller = CameraController(
        cameras.first,            // 最初のカメラを使用
         ResolutionPreset.medium, // 解像度を中解像度に設定
        enableAudio: false,       // マイクの権限を不要にする
      )
        // 初期化が完了したら状態を更新
        ..initialize().then((_) {
          setState(() {
            _cameraLoaded.complete(true);
          });
          // エラー処理
        }).onError((CameraException error, stackTrace) {
          // 権限不足の場合はその旨をダイアログに記載
          if (error.code == 'CameraAccessDenied') {
            showDialog(
              context: context,
              builder: (context) => const SimpleDialog(
                children: [Text('カメラに撮影許可を出してください')],
              ),
            );
          }
        });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                FutureBuilder<bool>(
                  // カメラの初期化が完了するまでローディングを表示
                  future: _cameraLoaded.future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error!}');
                    } else if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    // 撮影画面を表示
                    return CameraPreview(_controller);
                  },
                ),
                // ズームと撮影ボタン
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        // ズーム切り替えスイッチ
                        Row(
                          children: [
                            const Text('2倍ズーム'),
                            Switch(
                              value: _isZooming,
                              onChanged: zoomingChanged,
                            ),
                          ],
                        ),
                        Center(
                          // 撮影ボタン
                          child: FilledButton(
                            onPressed: _cameraLoaded.isCompleted && !_isTakingPicture
                                ? () {
                                    setState(() {
                                      _isTakingPicture = true;
                                    });
                                    onTakePicture(context).then((_) {
                                      setState(() {
                                        _isTakingPicture = false;
                                      });
                                    });
                                  }
                                : null,
                            child: const Text('撮影'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // 撮影された画像を表示
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.file(_imageFile!),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> onTakePicture(BuildContext context) async {
    final image = await _controller.takePicture();
    setState(() {
      _imageFile = File(image.path);
    });
    Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        _imageFile = null;
      });
    });
  }

  void zoomingChanged(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _isZooming = value;
    });
    _controller.setZoomLevel(_isZooming ? 2.0 : 1.0);
  }
}
