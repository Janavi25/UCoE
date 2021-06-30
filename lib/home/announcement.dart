import 'package:Ucoe/home/extendannouncemnet.dart';
import 'package:Ucoe/style/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class announcement extends StatefulWidget {
  @override
  _announcementState createState() => _announcementState();
}

class _announcementState extends State<announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff19196f),
        title: Text('Announcements'),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('announcements').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map<Widget>((documnet) {
                return Announce(documnet['head'], documnet['body']);
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Widget Announce(head, body) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => extenda(head: head, body: body)));
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
                          'https://www.freeiconspng.com/thumbs/bell-icons/bell-icon-8.png'))),
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
                      head,
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
                      body,
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
