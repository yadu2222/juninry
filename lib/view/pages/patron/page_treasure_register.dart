import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:juninry/view/components/atoms/listItem_box.dart';
import 'package:juninry/view/components/atoms/listitem.dart';
import 'package:juninry/view/components/atoms/toast.dart';
import 'package:juninry/view/components/molecule/ble_box_wifi_form.dart';
import 'package:juninry/view/components/molecule/ble_card.dart';

import '../../components/template/basic_template.dart';

class PageTreasureRegister extends HookWidget {
  const PageTreasureRegister({
    super.key,
  });

  final String title = 'たからばこ';
  final String trasureBoxName = "Juninry-BOX";
  final String wifiConnectServiceUuid = "6b0b";
  final String wifiConnectSsidCharacteristicUuid = "cf09";
  final String wifiConnectPassCharacteristicUuid = "ee6a";

  @override
  Widget build(BuildContext context) {
    final imgPath = useState<String>("assets/images/close_treasure.png");
    final deviceList = useState<List<BluetoothDevice>>([]);
    final isList = useState<bool>(true);
    final connectedDevice = useState<BluetoothDevice?>(null);

    final ssidController = useTextEditingController();
    final passwordController = useTextEditingController();
    Future<void> scan() async {
      isList.value = false;
      deviceList.value.clear();
      // 5秒間Bluetoothデバイスをスキャン
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // スキャンの完了を待機する
      await Future.delayed(const Duration(seconds: 5));

      // スキャン結果をリスニングし、デバイス名が一致するデバイスを見つけたら接続
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          result.device.disconnect();
          // 新たに見つけたデバイスをリストに追加
          if (result.device.name != "" &&
              result.device.name == trasureBoxName &&
              !deviceList.value
                  .any((device) => device.id == result.device.id)) {
            deviceList.value = [...deviceList.value, result.device];
          }
        }
      });

      if (deviceList.value.isEmpty) {
        debugPrint("no device");
      }
      // スキャンを停止
      FlutterBluePlus.stopScan();

      isList.value = true;
    }

    Future<void> connectToDevice(BluetoothDevice device) async {
      // デバイスに接続
      try {
        await device.connect(
          timeout: const Duration(seconds: 5),
          autoConnect: false,
        );
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService service in services) {
          // 宝箱であることを確認する
          if (service.uuid.toString() == wifiConnectServiceUuid) {
            // 接続したデバイスを保存
            connectedDevice.value = device;
            ToastUtil.show(message: "宝箱に接続しました");
            break;
          } else {
            ToastUtil.show(message: "宝箱を認識できませんでした");
            device.disconnect();
          }
        }
      } catch (e) {
        ToastUtil.show(message: "宝箱に接続できませんでした");
        device.disconnect();
      }
    }

    Future<void> onSave() async {
      if (ssidController.text == "" || passwordController.text == "") {
        ToastUtil.show(message: "入力してください");
      } else {
        for (BluetoothService service
            in await connectedDevice.value!.discoverServices()) {
          // 宝箱であることを確認する
          if (service.uuid.toString() == wifiConnectServiceUuid) {
            for (BluetoothCharacteristic characteristic
                in service.characteristics) {
              if (characteristic.uuid.toString() ==
                  wifiConnectSsidCharacteristicUuid) {
                await characteristic.write(utf8.encode(ssidController.text));
              }
              if (characteristic.uuid.toString() ==
                  wifiConnectPassCharacteristicUuid) {
                await characteristic
                    .write(utf8.encode(passwordController.text));
              }
            }
          }
        }
      }
    }

    Future<void> onCancel(BluetoothDevice device) async {
      debugPrint("cancel");
      debugPrint(device.name.toString());
      ssidController.clear();
      passwordController.clear();
      connectedDevice.value = null;
      device.disconnect();
    }

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      Expanded(
        child: isList.value
            ? deviceList.value.isNotEmpty
                ? ListItemBox(
                    itemDatas: deviceList.value,
                    listItem: (device) => ListItem(
                        widget: BleCard(
                      device: device,
                      onTap: connectToDevice,
                      wifiForm: connectedDevice.value?.name == device.name
                          ? BoxWifiForm(
                              ssidController: ssidController,
                              passwordController: passwordController,
                              onSave: onSave,
                              onCancel: () => onCancel(device),
                            )
                          : const Text("接続していません", style: Fonts.h5),
                    )),
                  )
                : const Center(child: Text("宝箱をタップで検索", style: Fonts.h5))
            : const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("宝箱を探しています...", style: Fonts.h5),
                ],
              )),
      ),
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
