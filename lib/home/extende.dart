import 'package:flutter/material.dart';

class extende extends StatefulWidget {
  var name, desc, func;
  extende({@required this.name, @required this.desc, @required this.func});
  @override
  _extendeState createState() =>
      _extendeState(name: name, desc: desc, func: func);
}

class _extendeState extends State<extende> {
  var name, desc, func;
  _extendeState(
      {@required this.name, @required this.desc, @required this.func});
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
                          "https://image.flaticon.com/icons/png/512/1458/1458512.png"))),
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
                name,
                maxLines: 500,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                    fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 30),
              child: Text(
                desc,
                maxLines: 500,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 50),
              child: Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 30),
              child: Text(
                func,
                maxLines: 1000,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
