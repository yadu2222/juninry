import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/ouchi_req.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
import 'package:juninry/models/ouchi_model.dart';
import 'package:juninry/view/components/organism/ouchi_membar_list.dart';
import 'package:juninry/view/components/template/basic_template.dart';

class PageOuchiInfo extends HookWidget {
  const PageOuchiInfo({super.key});

  @override
  Widget build(BuildContext context) {
    OUCHIReq ouchiReq = OUCHIReq(context); // ClassReqクラスのインスタンスを生成
    final ouchiData = useState<Ouchi?>(null); // 児童か判別

    useEffect(() {
      // ouchiData取得
      Future<void> fetchData() async {
        Ouchi ouchi = await ouchiReq.getOuchiMembersHandler();
        ouchiData.value = ouchi;
      }

      fetchData();
      return () {};
    }, []);
    // ouchiの判別中はローディングを表示
    if (ouchiData.value == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return BasicTemplate(title: 'おうち情報', children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              const Icon(
                Icons.home,
                size: 30,
                color: AppColors.iconLight,
              ),
              const SizedBox(width: 10),
              Text(ouchiData.value!.ouchiName, style: Fonts.h4w)
            ])),
            Expanded(child: OuchiMembarList(users : ouchiData.value!.members!))
      ]);
    }
  }
}
