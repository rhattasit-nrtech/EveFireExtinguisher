import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evefireextin/models/user_model.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:evefireextin/utility/my_dialog.dart';
import 'package:evefireextin/widgets/show_image.dart';
import 'package:evefireextin/widgets/show_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Authen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildImage(constraints),
                    buildAppName(),
                    fieldUser(constraints),
                    fieldPassword(constraints),
                    buttonLogin(constraints)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buttonLogin(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: constraints.maxWidth * 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyConstant.primary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<void> checkAuthen() async {
    String email = emailController.text;
    String password = passwordController.text;
    // print('## email = $email, password = $password');

    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        String uid = value.user!.uid;
        // print('## uid login ==> $uid');
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .get()
            .then((value) {
          // print('## value success Login ==>> ${value.data()}');
          UserModel userModel = UserModel.fromMap(value.data()!);
          String type = userModel.type;
          print('## type ==. $type');
          
          switch (type) {
            case 'admin':
              Navigator.pushNamedAndRemoveUntil(
                  context, MyConstant.routAdminService, (route) => false);
              break;
            case 'officer':
              Navigator.pushNamedAndRemoveUntil(
                  context, MyConstant.routOfficerService, (route) => false);
              break;
            default:
          }
        });
      }).catchError((onError) {
        // String message = onError.message.toString as String;
        // print('## onError ==> $onError');
        MyDialog().normalDialog(context, onError.toString());
      });
    });
  }

  Container fieldUser(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      width: constraints.maxWidth * 0.6,
      height: 60,
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill email in blank';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email :',
          prefixIcon: Icon(Icons.email),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
        ),
      ),
    );
  }

  Container fieldPassword(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      width: constraints.maxWidth * 0.6,
      height: 60,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill password in blank';
          } else {
            return null;
          }
        },
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Password :',
          prefixIcon: Icon(Icons.lock_outline),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
        ),
      ),
    );
  }

  ShowTitle buildAppName() {
    return ShowTitle(
      title: MyConstant.appName,
      textStyle: MyConstant().h1Style(),
    );
  }

  Container buildImage(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      child: ShowImage(path: 'images/fecover.png'),
    );
  }
}
