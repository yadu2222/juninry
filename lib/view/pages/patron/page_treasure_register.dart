import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../components/template/basic_template.dart';

class PageTreasureRegister extends HookWidget {
  const PageTreasureRegister({
    super.key,
  });

  final String title = 'たからばこ';

  @override
  Widget build(BuildContext context) {
    final imgPath = useState<String>("assets/images/close_treasure.png");
    final deviceList = useState<List<BluetoothDevice>>([]);
    final isList = useState<bool>(true);
    final isLoding = useState<bool>(false);

    Future<void> scan() async {
      isList.value = false;
      // 5秒間Bluetoothデバイスをスキャン
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // スキャン結果をリスニングし、デバイス名が一致するデバイスを見つけたら接続
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          deviceList.value = [...deviceList.value, result.device];
        }
      });
    }

    Future<void> connectToDevice(BluetoothDevice device) async {
      // デバイスに接続
      await device.connect();
      deviceList.value.clear(); // リストをクリア
    }

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      const Spacer(),
      isList.value
          ? Expanded(
              child: ListView(
              children: deviceList.value.map((device) {
                return ListTile(
                  title: Text(device.name), // デバイス名を表示
                  onTap: () {
                    connectToDevice(device);
                  },
                );
              }).toList(),
            ))
          : const Text("たからばこをタップしてね", style: Fonts.h4w),
      const Spacer(),
      InkWell(
          onTap: () {
            scan();
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(10),
            child: Image.asset(imgPath.value, fit: BoxFit.cover),
          ))
    ]);
  }
}
