import 'package:Ucoe/LocationMap/MapScreen.dart';
import 'package:Ucoe/Model/bustrack.dart';
import 'package:Ucoe/Screens/Mappage.dart';
// import 'package:Ucoe/LocationMap/mappp.dart';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/mapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class bus extends StatefulWidget {
  String busval, location;
  bus({@required this.busval, @required this.location});
  @override
  _busState createState() => _busState(busval: busval, location: location);
}

class _busState extends State<bus> {
  String busval, location;
  _busState({@required this.busval, @required this.location});
  var uid;
  var doc;
  bustrack bust;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(location + busval)
          .doc('location')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return loadingwidget();
        } else {
          var doc = snapshot.data;
          return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Column(
                children: [
                  Expanded(
                      child: MapPage(
                    busval: busval,
                    location: location,
                  )),
                  Container(
                    height: 100,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey[600],
                            blurRadius: 0.1,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0))),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: 80,
                          child: Image(
                            image: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/janavi25preaload.appspot.com/o/chauffeur.png?alt=media&token=25f50195-3071-4a9a-94a1-2b9f4350e589'),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                'Call Driver',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                // bust.Phone,
                                doc['Phone'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => launch("tel://" + doc["Phone"]),
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 20),
                            margin: EdgeInsets.only(left: 40, right: 10),
                            width: 80,
                            child: Image(
                              image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/janavi25preaload.appspot.com/o/phone-call.png?alt=media&token=aa23bc7f-29f1-4e35-8d88-b47153e25f8e'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    doc = FirebaseFirestore.instance
        .collection(location + busval)
        .doc('location')
        .get();
    // print(doc.data);
    setState(() {
      bust = bustrack.fromDocument(doc);
    });
    // print(bust.Phone);
  }

  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
