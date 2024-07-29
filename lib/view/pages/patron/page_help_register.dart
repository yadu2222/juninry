import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/atoms/info_form.dart';
import '../../components/molecule/help_icons.dart';
// api
import '../../../apis/controller/help_req.dart';
// model
import '../../../models/help_model.dart';

class PageHelpRegisterPatron extends HookWidget {
  const PageHelpRegisterPatron({super.key});

  final String title = 'おてつだい登録';

  @override
  Widget build(BuildContext context) {
    HelpReq helpReq = HelpReq(context: context);

    final iconId = useState<int>(0); // 選択中のid
    final choiceIcon = useState<List<bool>>(List.generate(10, (i) => i == iconId.value)); // 選択中かを判別するためのリスト

    // useTextEditingControllerを使うことで再ビルド時にも値が保持される
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final rewardPointController = useTextEditingController();

    // アイコン選択
    void choiceIconHandler(int id) {
      iconId.value = id; // 選択中のアイコンを更新
      choiceIcon.value = List.generate(5, (i) => i == id); // 初期化し、選択されたもののみtrue
    }

    void registeHelp() {
      // おてつだい登録処理
      Help help = Help(
        helpTitle: titleController.text,
        helpContent: contentController.text,
        iconId: iconId.value,
        rewardPoint: int.parse(rewardPointController.text),
        // rewardPoint: 15
      );
      helpReq.registerHelpHandler(help).then((_) => Navigator.pop(context));
    }

    return BasicTemplate(title: title, children: [
      HelpIcons(choiceIcon: choiceIcon.value, choiceIconHandler: choiceIconHandler),
      InfoForm(label: 'タイトル', controller: titleController),
      InfoForm(label: '概要', controller: contentController),
      InfoForm(
        label: 'ポイント',
        controller: rewardPointController,
        inputType: TextInputType.number,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      ),
      const SizedBox(
        height: 20,
      ),
      BasicButton(text: '登録', isColor: false, onPressed: registeHelp),
    ]);
  }
}
