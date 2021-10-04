import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evefireextin/models/extinguisher_model.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/show_progress.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<ExtinguisherModel> extinguisherModels = [];
  bool load = true;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      // print('Firebase Initial Success');
      await FirebaseFirestore.instance
          .collection('extinguisher')
          .get()
          .then((value) {
        // print('value = ${value.docs}');
        for (var item in value.docs) {
          // print('sanpshot ==> ${item.data()}');
          ExtinguisherModel model = ExtinguisherModel.fromMap(item.data());
          print('name ===> ${model.name}');
          setState(() {
            load = false;
            extinguisherModels.add(model);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(MyConstant.appName),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              fieldSearch(constraints),
              load
                  ? ShowProgress()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: extinguisherModels.length,
                      itemBuilder: (context, index) =>
                          Text(extinguisherModels[index].name),
                    ),
            ],
          ),
        ));
  }

  Row fieldSearch(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.8,
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
