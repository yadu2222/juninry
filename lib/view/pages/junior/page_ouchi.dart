import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import './page_join_ouchi.dart';
import 'page_ouchi_top.dart';
// api
import 'package:juninry/apis/controller/user_req.dart';
// model
import '../../../models/user_model.dart';

class PageOUCHIJunior extends HookWidget {
  const PageOUCHIJunior({super.key});

  // pageをpageにいれるなんてそんなことしていいのかしらのきもちが ある
  @override
  Widget build(BuildContext context) {
    UserReq userReq = UserReq(context: context); // ClassReqクラスのインスタンスを生成
    final isOUCHI = useState<bool?>(null); // おうちか判別
    useEffect(() {
      // おうちに参加してるかをチェックし、遷移
      Future<void> fetchData() async {
        User user = await userReq.getUserHandler();
        isOUCHI.value = user.ouchiUUID != null;
      }

      fetchData();
      return () {};
    }, []);

    // ouchiの判別中はローディングを表示
    if (isOUCHI.value == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return isOUCHI.value! ? PageOuchiTop() : PageJoinOUCHI();
    }
  }
}
