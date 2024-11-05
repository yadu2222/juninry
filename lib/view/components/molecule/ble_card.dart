import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:juninry/constant/fonts.dart';

class BleCard extends StatefulWidget {
  final BluetoothDevice device;
  final Function(BluetoothDevice device) onTap;
  final Widget wifiForm;

  const BleCard(
      {super.key,
      required this.device,
      required this.onTap,
      required this.wifiForm});

  @override
  State<BleCard> createState() => _BleCardState();
}

class _BleCardState extends State<BleCard> {
  bool isConnectTrying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              isConnectTrying = true;
            });
            await widget.onTap(widget.device);
            setState(() {
              isConnectTrying = false;
            });
          },
          child: Row(
            children: [
              Text(widget.device.name, style: Fonts.h4),
              const SizedBox(width: 10),
              isConnectTrying
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const Divider(thickness: 1, indent: 0, endIndent: 0),
        AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: widget.wifiForm),
      ],
    );
  }
}
