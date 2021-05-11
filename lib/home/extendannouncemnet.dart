import 'package:flutter/material.dart';

class extenda extends StatefulWidget {
  var head, body;
  extenda({@required this.head, @required this.body});
  @override
  _extendaState createState() => _extendaState(head: head, body: body);
}

class _extendaState extends State<extenda> {
  var head, body;
  _extendaState({this.head, this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff19196f),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 30),
              alignment: Alignment.topLeft,
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://image3.mouthshut.com/images/imagesp/925769502s.png"))),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xff19196f),
                thickness: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 30),
              child: Text(
                head,
                maxLines: 500,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                    fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 30),
              child: Text(
                body,
                maxLines: 1000,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
