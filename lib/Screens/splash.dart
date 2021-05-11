import 'dart:async';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/Login.dart';
import 'package:Ucoe/Screens/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  User user;
  var fuid, email, password, uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), () {
      print('this function will work');
      getData();
      directLogin();
      // Navigator.of(context).pop();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    });
  }

  directLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    String password = prefs.getString('password');
    String uid = prefs.getString('uid');
    if (uid != null) {
      if (uid == fuid) {
        print(fuid);
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      } else {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => login()));
      }
    } else {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    }
  }

  getData() async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyyyyyy");
    var user1 = FirebaseAuth.instance.currentUser;
    setState(() {
      user = user1;
      print(user1.uid);
      fuid = user.uid;
    });
    print(fuid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      password = prefs.getString('password');
      uid = prefs.getString('uid');
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return Scaffold(
        // backgroundColor: Colors.green,
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Image(
          image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/fir-auth-79ef2.appspot.com/o/logobus.png?alt=media&token=eb380ae5-e834-42ce-b097-88f7bd575150'),
        ),
      ),
    ));
  }
}
