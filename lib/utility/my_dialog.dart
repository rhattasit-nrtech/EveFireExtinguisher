import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/show_image.dart';
import 'package:evefireextin/widgets/show_title.dart';
import 'package:flutter/material.dart';

class MyDialog {
  Future<void> progressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }

  Future<void> normalDialog(BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: 'images/authen.png'),
          title: ShowTitle(
            title: 'Have Error ?',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(title: message),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
