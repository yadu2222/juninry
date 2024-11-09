import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/collection_req.dart';
import 'package:juninry/constant/colors.dart';
import 'package:juninry/constant/fonts.dart';
// import 'package:go_router/go_router.dart';
import 'package:juninry/models/collection_model.dart';
import 'package:juninry/view/components/molecule/collection_box.dart';
import 'package:juninry/view/components/molecule/divider.dart';

// view
import '../../components/template/basic_template.dart';

class PageCollection extends HookWidget {
  PageCollection({super.key});

  final String title = 'ずかん';
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final collectionReq = CollectionReq(context: context);
    final itemCollections = useState<List<Collection>>(Collection.itemCollection);
    final nyariotCollections = useState<List<Collection>>(Collection.nyariotCollection);

    void showDetail(Collection collection) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 0.0, // ダイアログの影を削除
              backgroundColor: Colors.transparent, // 背景色
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                  height: 400,
                  width: 450,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(
                              "No.${collection.collectionID.toString()}",
                              style: Fonts.h5,
                            ),
                            Text(
                              collection.name,
                              style: Fonts.h5,
                            ),
                          ])),
                      CollectionBox(
                        imagePath: collection.imgPath,
                        width: 250,
                      ),
                      Padding(padding: EdgeInsets.all(10), child: Text(collection.description, style: Fonts.p)),
                      // Text(collection.talk),
                    ],
                  )),
            );
          });
    }

    useEffect(() {
      Future<void> getCollection() async {
        itemCollections.value = await collectionReq.getItems(); // アイテム取得
        nyariotCollections.value = await collectionReq.getNyariots(); // ニャリオット取得
        // nyariotCollections.value = await getCollection();
        debugPrint(itemCollections.value.toString());
      }

      getCollection();
      return () {};
    }, []);

    return BasicTemplate(title: title, children: [
      Expanded(
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(children: [
                    const DividerView(
                      title: "ニャリオット",
                      endIndent: 0,
                      indent: 0,
                    ),
                    Wrap(
                        children: nyariotCollections.value.map((collection) {
                      return InkWell(
                          onTap: () {
                            showDetail(collection);
                          },
                          child: CollectionBox(imagePath: collection.imgPath));
                    }).toList()),
                    const DividerView(
                      title: "アイテム",
                      endIndent: 0,
                      indent: 0,
                    ),
                    Wrap(
                        children: itemCollections.value.map((collection) {
                      return InkWell(
                          onTap: () {
                            showDetail(collection);
                          },
                          child: CollectionBox(imagePath: collection.imgPath));
                    }).toList())
                  ]))))
    ]);
  }
}
