import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/show_image.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.dark,
        title: const Text('Authen'),
      ),body: ShowImage(path: 'images/authen.png'),
    );
  }
}
