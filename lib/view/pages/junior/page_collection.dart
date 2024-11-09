import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juninry/apis/controller/collection_req.dart';
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

    useEffect(() {
      Future<void> getCollection() async {
        itemCollections.value = await collectionReq.getItems();
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
                      return CollectionBox(imagePath: collection.imgPath);
                    }).toList()),
                    const DividerView(
                      title: "アイテム",
                      endIndent: 0,
                      indent: 0,
                    ),
                    Wrap(
                        children: itemCollections.value.map((collection) {
                      return CollectionBox(imagePath: collection.imgPath);
                    }).toList())
                  ]))))
    ]);
  }
}
