import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/view/pages/junior/page_ouchi_join.dart';
import 'package:juninry/view/pages/junior/page_ouchi_top.dart';
import '../patron/page_ouchi_top.dart';
import '../patron/page_ouchi_create.dart';
// api
import 'package:juninry/apis/controller/user_req.dart';
// model
import '../../../models/user_model.dart';

class PageOuchi extends HookWidget {
  const PageOuchi({super.key});

  @override
  Widget build(BuildContext context) {
    UserReq userReq = UserReq(context: context); // ClassReqクラスのインスタンスを生成
    final isJunior = useState<bool?>(null); // 児童か判別
    final isOUCHI = useState<bool?>(null); // おうちUUIDの有無を判別
    useEffect(() {
      Future<void> fetchData() async {
        // おうちに参加してるかをチェックし、遷移
        User user = await userReq.getUserHandler();
        isOUCHI.value = user.ouchiUUID != null; // true おうちある
        // ついでに児童か判別
        isJunior.value = user.userTypeId == 2;
      }

      fetchData();
      return () {};
    }, []);
    // ouchiの判別中はローディングを表示
    if (isOUCHI.value == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      if (isOUCHI.value!) {
        // おうちある(トップ)
        return isJunior.value! ? PageOuchiTopJunior() : const PageOuchiTopPatron();
      } else {
        // おうちない(参加または作成画面)
        return isJunior.value! ? PageJoinOuchi() : PageCreateOuchi();
        
      }
    }
  }
}
