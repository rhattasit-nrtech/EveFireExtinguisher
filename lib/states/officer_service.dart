import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/build_signout.dart';
import 'package:evefireextin/widgets/show_title.dart';
import 'package:flutter/material.dart';

class OfficerService extends StatefulWidget {
  const OfficerService({Key? key}) : super(key: key);

  @override
  _OfficerServiceState createState() => _OfficerServiceState();
}

class _OfficerServiceState extends State<OfficerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Officer'),
      ),
      drawer: Drawer(
        child: BuildSignOut(),
      ),
    );
  }
}
