import 'package:Ucoe/Tabs/Profile.dart';
import 'package:Ucoe/Tabs/Track.dart';
import 'package:Ucoe/style/colour.dart';
import 'package:Ucoe/style/decoration.dart';
import 'package:Ucoe/style/text.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

colour color = colour();
decoration deco = decoration();
text txt = text();

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Color a, b, c;

  var _currentindex = 0;
  final tabs = [
    Center(
      child: Track(),
    ),
    Center(
      child: Track(),
    ),
    Center(
      child: Profile(),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColor();
  }

  @override
  Widget build(BuildContext context) {
    onWillPop() {
      DialogBox(context);
    }

    return WillPopScope(
        child: Scaffold(
          body: tabs[_currentindex],
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.grey[100],
              buttonBackgroundColor: Colors.red[400],
              items: [
                Icon(Icons.home),
                Icon(Icons.add_circle),
                Icon(Icons.account_circle_outlined),
              ],
              onTap: (index) {
                setState(() {
                  _currentindex = index;
                });
              }),
        ),
        onWillPop: onWillPop);
  }

  getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String color = prefs.getString('color');
    print(color);
    switch (color) {
      case 'a':
        setState(() {
          a = Color(0xffff3985);
          b = Color(0xffff858d);
          c = Color(0xffff4f86);
        });
        break;
      case 'b':
        setState(() {
          a = Color(0xff3a506b);
          b = Color(0xff5bc0be);
          c = Color(0xff6fffe9);
        });
        break;
    }
  }
}

void DialogBox(context) {
  var baseDialog = AlertDialog(
    title: new Text("Close the App"),
    // content: Container(
    //   color: Colors.black,
    //   height: 100,
    // ),
    actions: <Widget>[
      FlatButton(
        color: color.theme1,
        child: new Text("Exit App", style: txt.lailaverysmall),
        onPressed: () {
          SystemNavigator.pop();
        },
      ),
    ],
  );

  showDialog(context: context, builder: (BuildContext context) => baseDialog);
}
