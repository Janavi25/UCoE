// import 'package:Ucoe/Tabs/Profile.dart';
// import 'package:Ucoe/Tabs/Track.dart';
// import 'package:Ucoe/Tabs/home.dart';
// import 'package:Ucoe/style/colour.dart';
// import 'package:Ucoe/style/decoration.dart';
// import 'package:Ucoe/style/text.dart';
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/services.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// colour color = colour();
// decoration deco = decoration();
// text txt = text();

// class Navigation extends StatefulWidget {
//   int n;
//   Navigation({this.n});
//   @override
//   NavigationState createState() => NavigationState(n: n);
// }

// class NavigationState extends State<Navigation> {
//   Color a, b, c;
//   int n;
//   NavigationState({@required this.n});
//   var currentindex;
//   callfunc(n) {
//     // setState(() {
//     //   _currentindex = n;
//     // });
//     currentindex = n;
//     print('called callfunc');
//     print(currentindex);
//     // setState(() {

//     // });
//   }

//   final tabs = [
//     Center(
//       child: home(),
//     ),
//     Center(
//       child: Track(),
//     ),
//     Center(
//       child: Profile(),
//     ),
//     Center(
//       child: Track(),
//     ),
//   ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getColor();
//     callfunc(n);
//   }

//   @override
//   Widget build(BuildContext context) {
//     onWillPop() {
//       DialogBox(context);
//     }

//     return WillPopScope(
//         child: Scaffold(
//           body: tabs[currentindex],
//           bottomNavigationBar: CurvedNavigationBar(
//               backgroundColor: Colors.grey[100],
//               buttonBackgroundColor: Colors.red[300],
//               items: [
//                 Icon(Icons.home),
//                 Icon(Icons.bus_alert),
//                 Icon(Icons.fact_check),
//                 Icon(Icons.account_circle)
//               ],
//               onTap: (index) {
//                 setState(() {
//                   currentindex = index;
//                 });
//               }),
//         ),
//         onWillPop: onWillPop);
//   }

//   getColor() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String color = prefs.getString('color');
//     print(color);
//     switch (color) {
//       case 'a':
//         setState(() {
//           a = Color(0xffff3985);
//           b = Color(0xffff858d);
//           c = Color(0xffff4f86);
//         });
//         break;
//       case 'b':
//         setState(() {
//           a = Color(0xff3a506b);
//           b = Color(0xff5bc0be);
//           c = Color(0xff6fffe9);
//         });
//         break;
//     }
//   }
// }

// void DialogBox(context) {
//   var baseDialog = AlertDialog(
//     title: new Text("Close the App"),
//     // content: Container(
//     //   color: Colors.black,
//     //   height: 100,
//     // ),
//     actions: <Widget>[
//       FlatButton(
//         color: color.theme1,
//         child: new Text("Exit App", style: txt.lailaverysmall),
//         onPressed: () {
//           SystemNavigator.pop();
//         },
//       ),
//     ],
//   );

//   showDialog(context: context, builder: (BuildContext context) => baseDialog);
// }

import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/Mappage.dart';
import 'package:Ucoe/Screens/bus.dart';
import 'package:Ucoe/Tabs/Profile.dart';
import 'package:Ucoe/Tabs/Track.dart';
import 'package:Ucoe/Tabs/fees.dart';
import 'package:Ucoe/Tabs/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var color = Colors.white;

class Navigation extends StatefulWidget {
  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      // physics: new NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          bottomSelectedIndex = index;
        });
        pageChanged(index);
      },
      children: <Widget>[home(), Track(), fees(), Profile()],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.indigo[900],
      // ),
      body: buildPageView(),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF19196f),
        backgroundColor: Colors.grey[50],
        buttonBackgroundColor: Color(0xFF19196f),
        index: bottomSelectedIndex,
        items: [
          Icon(
            Icons.home,
            color: color,
          ),
          Icon(
            Icons.bus_alert,
            color: color,
          ),
          Icon(
            Icons.fact_check,
            color: color,
          ),
          Icon(
            Icons.account_circle,
            color: color,
          )
        ],
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }
}
