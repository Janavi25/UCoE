import 'package:Ucoe/home/extende.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class event extends StatefulWidget {
  @override
  _eventState createState() => _eventState();
}

class _eventState extends State<event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff19196f),
        title: Text('Upcoming Events'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map<Widget>((document) {
                return Eventlist(document['eventdesc'], document['eventfunc'],
                    document['eventname']);
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Widget Eventlist(eventdesc, eventfunc, eventname) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => extende(
                    name: eventname, desc: eventdesc, func: eventfunc)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: shadowBox,

        height: 100,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.flaticon.com/icons/png/512/1458/1458512.png'))),
            ),
            Container(
              // width: 220,
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      eventname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      eventdesc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      eventfunc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey[800]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),

        // child: ,
      ),
    );
  }
}

BoxDecoration shadowBox = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(13)),
    // boxShadow: [
    //   BoxShadow(
    //     color: Colors.grey,
    //     offset: Offset(0.0, 0.75),
    //     spreadRadius: 0.96,
    //   )
    // ],
    boxShadow: [
      new BoxShadow(
        color: Colors.grey[600],
        blurRadius: 1,
        spreadRadius: 0.1,
      ),
    ],
    color: Colors.white);
