import 'dart:async';

import 'package:Ucoe/Screens/Login.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      print('this function will work');
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    });
  }

  @override
  Widget build(BuildContext context) {
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
