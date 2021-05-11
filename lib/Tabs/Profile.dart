import 'package:Ucoe/Model/UserProfile.dart';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color a, b, c;
  var uid;
  // userprofile localuser;
  DocumentSnapshot doc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  Widget circle(color) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: a,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(provider.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var doc = snapshot.data;
            return ProfilePage(doc['name'], doc['classroom'], doc['Photo'],
                doc['phone'], doc['email'], doc['location']);
          }
        },
      ),
      // FutureBuilder(
      //   future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (!snapshot.hasData) {
      //       return loadingwidget();
      //     } else {
      //       return ProfilePage();
      //     }
      //   },
      // ),
    ));
  }

  Widget ProfilePage(name, classroom, Photo, phone, email, location) {
    return Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.grey[50],
              child: Stack(
                children: [
                  // The containers in the background
                  new Column(
                    children: [
                      new Container(
                        height: MediaQuery.of(context).size.height * .32,
                        decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   colors: [
                            //     const Color(0xff330867),
                            //     const Color(0xFF30cfd0),
                            //   ],
                            // ),
                            color: Color(0xff19196f),
                            borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0))),
                      ),
                      // new Container(
                      //   height: MediaQuery.of(context).size.height * .35,
                      //   color: Colors.white,
                      // )
                    ],
                  ),

                  Container(
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .20,
                        right: 23.0,
                        left: 23.0),
                    child: new Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        // elevation: 6.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey[600],
                              blurRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 80,
                              ),
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // gradient: LinearGradient(
                                          //   colors: [
                                          //     const Color(0xff330867),
                                          //     const Color(0xFF30cfd0),
                                          //   ],
                                          // ),
                                          color: Color(0xff19196f),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[400],
                                            ),
                                            BoxShadow(
                                              color: Colors.grey[300],
                                              spreadRadius: 2.0,
                                              blurRadius: 12.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        left: 40,
                                      ),
                                      width: 180,
                                      // color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                      height: 40,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DialogBoxLogOut(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[400],
                                            ),
                                            BoxShadow(
                                              color: Colors.white,
                                              spreadRadius: -12.0,
                                              blurRadius: 12.0,
                                            ),
                                          ],
                                          border: new Border.all(
                                              color: Colors.grey[300]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        left: 20,
                                      ),
                                      height: 40,
                                      width: 40,
                                      // color: Colors.red,
                                      child: Center(
                                          child: Icon(
                                        Icons.logout,
                                        color: Colors.grey[800],
                                        size: 23,
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * .15,
                  //   margin: EdgeInsets.only(right: 230),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[300],
                  //     borderRadius: BorderRadius.only(
                  //         bottomRight: Radius.circular(150),
                  //         topRight: Radius.circular(2)),
                  //     boxShadow: [
                  //       new BoxShadow(
                  //         color: Colors.grey[600],
                  //         blurRadius: 1.0,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Wrap(
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          margin: EdgeInsets.only(top: 65),
                          // margin: EdgeInsets.all(100.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey[600],
                                  blurRadius: 3.0,
                                ),
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(Photo))),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                height: 400.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.grey[50],
                  // elevation: 6.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 25,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(
                                left: 25,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: new Border.all(
                                  color: Colors.grey[300],
                                ),
                              ),
                              child: Icon(
                                Icons.email_rounded,
                                color: Colors.red[400],
                                size: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                email,
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 30,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(
                                left: 25,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: new Border.all(
                                  color: Colors.grey[300],
                                ),
                              ),
                              child: Icon(
                                Icons.local_phone_rounded,
                                color: Colors.green,
                                size: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                phone,
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 30,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(
                                left: 25,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: new Border.all(
                                  color: Colors.grey[300],
                                ),
                              ),
                              child: Icon(
                                Icons.school,
                                color: Colors.yellow[800],
                                size: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                classroom,
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 30,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(
                                left: 25,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: new Border.all(
                                  color: Colors.grey[300],
                                ),
                              ),
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.blue[800],
                                size: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                location,
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void DialogBoxLogOut(context) {
    var baseDialog = AlertDialog(
      title: new Text("👋🏻 Logout"),
      content: Container(
        child: Text('Are you sure you want to logout?'),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.indigo[900],
          child: new Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.clear();
            FirebaseAuth.instance.signOut();
            SystemNavigator.pop();
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  func() async {}
  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   uid = prefs.getString('uid');
  //   doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   print(doc.data);
  //   setState(() {
  //     localuser = userprofile.fromDocument(doc);
  //   });
  //   print(localuser.email);
  // }
}
