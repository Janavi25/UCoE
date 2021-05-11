import 'package:Ucoe/Model/UserProfile.dart';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/Mappage.dart';
import 'package:Ucoe/Screens/bus.dart';
import 'package:Ucoe/style/colour.dart';
import 'package:Ucoe/style/decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  var uid;
  userprofile localuser;
  DocumentSnapshot doc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loadingwidget();
          } else {
            return Scaffold(
                body: ListView(
              children: [
                Wrap(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Track your bus now',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 110,
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.freeiconspng.com/thumbs/bus-png/red-bus-png-clipart-3.png'))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.red[50],
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey[600],
                          blurRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mira Road',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Click the button below to track your bus',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus1',
                                                location: 'Mira Road')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 1',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus2',
                                                location: 'Mira Road')));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 2',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus3',
                                                location: 'Mira Road')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 3',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.green[50],
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey[600],
                          blurRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Vasai',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Click the button below to track your bus',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus1',
                                                location: 'Vasai')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 1',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus2',
                                                location: 'Vasai')));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 2',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus3',
                                                location: 'Vasai')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 3',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus4',
                                                location: 'Vasai')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 4',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.amber[50],
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey[600],
                          blurRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Borivali',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Click the button below to track your bus',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus1',
                                                location: 'Borivali')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 1',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus2',
                                                location: 'Borivali')));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 2',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus3',
                                                location: 'Borivali')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 3',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey[600],
                          blurRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Thane',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Click the button below to track your bus',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus1',
                                                location: 'Thane')));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 1',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bus(
                                                busval: 'bus2',
                                                location: 'Thane')));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(
                                      'Bus 2',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ));
          }
        });
  }

  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print(doc.data);
    setState(() {
      localuser = userprofile.fromDocument(doc);
    });
    print(localuser.email);
  }
}
