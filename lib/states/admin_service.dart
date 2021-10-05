import 'package:evefireextin/bodys/show_extinguisher.dart';
import 'package:evefireextin/bodys/show_officer.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/widgets/build_signout.dart';
import 'package:evefireextin/widgets/show_title.dart';
import 'package:flutter/material.dart';

class AdminService extends StatefulWidget {
  const AdminService({Key? key}) : super(key: key);

  @override
  _AdminServiceState createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  List<Widget> widgets = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widgets.add(ShowExtinguisher());
    widgets.add(ShowOfficer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Admin'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            BuildSignOut(),
            Column(
              children: [
                buildHeader(),
                menuShowExtinguisher(),
                menuShowOfficer(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[index],
    );
  }

  ListTile menuShowExtinguisher() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          index = 0;
        });
      },
      leading: Icon(
        Icons.filter_1,
        color: MyConstant.primary,
      ),
      title: ShowTitle(
        title: 'Show Extinguisher',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  ListTile menuShowOfficer() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          index = 1;
        });
      },
      leading: Icon(
        Icons.filter_1,
        color: MyConstant.primary,
      ),
      title: ShowTitle(
        title: 'Show Officer',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
