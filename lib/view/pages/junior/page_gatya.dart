import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

// view
import '../../components/template/basic_template.dart';

class PageGatya extends HookWidget {
  PageGatya({super.key});

  final String title = 'ガチャ';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      Expanded(
          child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              // decoration: BoxDecoration(
              //     color: AppColors.iconLight,
              //     // border: Border.all(color: AppColors.iconLight),
              //     borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                Image.asset("assets/images/haikei.png", fit: BoxFit.contain),
                Column(children: [
                  SizedBox(
                      width: 500,
                      height: 500,
                      child: Image.asset(
                        'assets/images/gatya.png',
                        width: 200,
                        fit: BoxFit.contain,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            context.go("/nyariot/gatya/gatyagatya", extra: {'isFirst': true});
                          },
                          child: Image.asset(
                            "assets/images/1_button.png",
                            height: 60,
                          )),
                      const SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            context.go("/nyariot/gatya/gatyagatya", extra: {'isFirst': false});
                          },
                          child: Image.asset(
                            "assets/images/11_button.png",
                            height: 60,
                          ))
                    ],
                  )
                ])
              ])
              // せりふ
              ))
    ]);
  }
}
