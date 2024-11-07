import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:go_router/go_router.dart';
// view
import '../../components/template/basic_template.dart';

class PageMeal extends HookWidget {
  PageMeal({super.key});

  final String title = 'たべもの';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stampBool = useState<List<bool>>([false, false, false, false, false, false, false]);
    final stamp = useState<int>(0);

    useEffect(() {
      void getStamp() async {
        // スタンプの数を取得
        // stamp.value = await getStamp();
        // スタンプの数によってboolを変更
        for (int i = 0; i < stamp.value; i++) {
          stampBool.value[i] = true;
        }
      }

      getStamp();

      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
     Text("たべもの")
    ]);
  }
}
