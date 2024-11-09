import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/treasure_model.dart';
import 'package:lottie/lottie.dart';

import '../../components/template/basic_template.dart';

class PageTreasure extends HookWidget {
  final Treasure treasure;
  const PageTreasure({
    super.key,
    required this.treasure,
  });

  final String title = 'たからばこ';

  @override
  Widget build(BuildContext context) {
    final imgPath = useState<String>("assets/images/close_treasure.png");
    final AnimationController controller = useAnimationController();

    Future<void> open() async {
      // たからばこを開く処理
      imgPath.value = "assets/images/open_treasure.png";
    }

    useEffect(() {
      return () {};
    }, []);

    // テンプレート呼び出し
    return BasicTemplate(title: title, children: [
      const Spacer(),
      const Text("たからばこをタップしてね", style: Fonts.h4w),
      const Spacer(),
      InkWell(
          onTap: () {
            open();
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(10),
            child: Image.asset(imgPath.value, fit: BoxFit.cover),
          ))
      // child: Container(
      //   width: 300,
      //   height: 300,
      //   padding: const EdgeInsets.all(10),
      //   child: Lottie.asset(
      //     'assets/lotties/lottie_treasure.json', // Lottieファイルのパス
      //     controller: controller,
      //     onLoaded: (composition) {
      //       controller.duration = composition.duration;
      //       controller.repeat();
      //     },
      //   ),
      // )),
    ]);
  }
}
