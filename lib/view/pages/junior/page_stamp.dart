import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/collection_req.dart';
import 'package:juninry/view/components/molecule/stamp.dart';
// view
import '../../components/template/basic_template.dart';

class PageStamp extends HookWidget {
  PageStamp({super.key});

  final String title = 'スタンプカード';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionReq collectionReq = CollectionReq(context: context);
    final stampBool = useState<List<bool>>([false, false, false, false, false, false, false]);
    final stamp = useState<int>(5);

    useEffect(() {
      void getStamp() async {
        // スタンプの数を取得
        stamp.value = await collectionReq.getStamps();
        // スタンプの数によってboolを変更
        for (int i = 0; i < stamp.value; i++) {
          stampBool.value[i] = true;
        }
      }

      getStamp();

      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      // stampの画像を表示
      Stack(children: [
        const Image(
          image: AssetImage('assets/images/stamp_card.png'),
        ),
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  StampBox(isStamp: stampBool.value[0]),
                  StampBox(isStamp: stampBool.value[1]),
                  StampBox(isStamp: stampBool.value[2]),
                  StampBox(isStamp: stampBool.value[3]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  StampBox(isStamp: stampBool.value[4]),
                  StampBox(isStamp: stampBool.value[5]),
                  StampBox(isStamp: stampBool.value[6]),
                ],
              ),
            ),
          ],
        )
      ])
    ]);
  }
}
