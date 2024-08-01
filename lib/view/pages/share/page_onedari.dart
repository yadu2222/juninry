import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../components/template/basic_template.dart';

import '../../components/organism/exchange_list.dart';

import '../../components/atoms/alert_dialog.dart';
import '../../../constant/messages.dart';
import '../../../router/router.dart';
import '../../../models/exchange_model.dart';

import '../../../apis/controller/reward_req.dart';

class PageOnedari extends HookWidget {
  // タイトル
  final String title = 'ONEDARI';
  // 右上に表示するアイコン
  final Icon featureIconButton = const Icon(
    Icons.drive_file_rename_outline_rounded,
    size: 30,
  );
  const PageOnedari({super.key});

  // 下書きリスト
  // dbから取得
  @override
  Widget build(BuildContext context) {
    final RewardReq rewardReq = RewardReq(context: context);
    final exchangeData = useState<List<Exchange>>([]);
    final isJunior = useState<bool>(false); // 児童かを判別

    // おねだりの記録を取得
    Future<void> getExchanges() async {
      final data = await rewardReq.getExchangesHandler();
      exchangeData.value = data;
    }

    // おねだりの消化
    Future<void> exchangeDigestion(Exchange exchange) async {
      rewardReq.digestExchangeHandler(exchange).then((_) {
        getExchanges();
      });
    }

    // 確認ダイアログ
    void checkExchange(Exchange exchange) {
      // 変更がある場合
      // 保存を促す

      if (!isJunior.value) {
        AlertDialogUtil.show(
          context: context,
          content: Messages.digestConfirmation,
          negativeAction: ("いいえ", () {}),
          positiveAction: (
            "はい",
            () async {
              await exchangeDigestion(exchange);
            }
          ),
        );
      }
    }

    useEffect(() {
      // 直接非同期関数を書くことはできない
      isBranch(BranchType.junior).then((value) => isJunior.value = value);
      getExchanges();
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      // 下書き一覧
      Expanded(
          // スクロールで再取得
          child: RefreshIndicator(
              onRefresh: () async {
                await getExchanges();
              },
              child: ExchangeList(
                isJunior: isJunior.value,
                exhanges: exchangeData.value,
                exchangeDigestion: checkExchange,
              )))
    ]);
  }
}
