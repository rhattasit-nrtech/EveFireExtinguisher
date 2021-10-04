import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evefireextin/models/extinguisher_model.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/show_network_image.dart';
import 'package:evefireextin/widgets/show_progress.dart';
import 'package:evefireextin/widgets/show_title.dart';
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
          backgroundColor: MyConstant.primary,
          title: Text(MyConstant.appName),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              buildHead(),
              menuLogin(),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              fieldSearch(constraints),
              load ? ShowProgress() : buildListView(),
            ],
          ),
        ));
  }

  ListTile menuLogin() {
    return ListTile(
      leading: Icon(
        Icons.login,
        color: MyConstant.dark,
        size: 36,
      ),
      title: ShowTitle(
        title: 'Login',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, MyConstant.routAuthen);
      },
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
      accountName: null,
      accountEmail: null,
    );
  }

  Widget buildListView() {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: extinguisherModels.length,
        itemBuilder: (context, index) => Card(
          child: Row(
            children: [
              Container(
                width: constraints.maxWidth * 0.35,
                height: constraints.maxWidth * 0.35,
                child:
                    ShowNetworkImage(urlImage: extinguisherModels[index].image),
              ),
              Container(
                width: constraints.maxWidth * 0.65 - 8,
                height: constraints.maxWidth * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowTitle(
                      title: extinguisherModels[index].name,
                      textStyle: MyConstant().h2Style(),
                    ),
                    ShowTitle(
                      title: extinguisherModels[index].location,
                      textStyle: MyConstant().h3Style(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
