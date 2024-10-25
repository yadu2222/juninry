import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../../components/template/basic_template.dart';
import '../../components/atoms/basic_button.dart';
import '../../components/atoms/info_form.dart';
import '../../components/molecule/reward_icons.dart';
// api
import '../../../apis/controller/reward_req.dart';
// model
import '../../../models/reward_model.dart';

class PageRewardRegisterPatron extends HookWidget {
  const PageRewardRegisterPatron({super.key});

  final String title = 'GOHOUBI登録';

  @override
  Widget build(BuildContext context) {
    RewardReq rewardReq = RewardReq(context: context);

    final iconId = useState<int>(0); // 選択中のid
    final choiceIcon = useState<List<bool>>(List.generate(10, (i) => i == iconId.value)); // 選択中かを判別するためのリスト

    // useTextEditingControllerを使うことで再ビルド時にも値が保持される
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final rewardPointController = useTextEditingController();

    // アイコン選択
    void choiceIconHandler(int id) {
      iconId.value = id; // 選択中のアイコンを更新
      choiceIcon.value = List.generate(10, (i) => i == id); // 初期化し、選択されたもののみtrue
    }

    void registeHelp() {
      // ごほうび登録処理
      Reward reward = Reward(
        rewardName: titleController.text,
        note: contentController.text,
        iconId: iconId.value,
        rewardPoint: int.parse(rewardPointController.text),
      );
      rewardReq.registerRewardHandler(reward).then((_) => Navigator.pop(context));
    }

    return BasicTemplate(title: title, children: [
      RewardIcons(choiceIcon: choiceIcon.value, choiceIconHandler: choiceIconHandler),
      InfoForm(label: 'タイトル', controller: titleController, inputFormatter: [LengthLimitingTextInputFormatter(10)]),
      InfoForm(
        label: '概要',
        controller: contentController,
        inputFormatter: [LengthLimitingTextInputFormatter(20)],
      ),
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
