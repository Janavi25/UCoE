import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Stack(
          children: [
            // The containers in the background
            new Column(
              children: [
                new Container(
                  height: MediaQuery.of(context).size.height * .40,
                  decoration: BoxDecoration(
                      color: const Color(0xFF330867),
                      borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(30.0),
                          bottomRight: const Radius.circular(30.0))),
                ),
                // new Container(
                //   height: MediaQuery.of(context).size.height * .35,
                //   color: Colors.white,
                // )
              ],
            ),

            new Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .28,
                  right: 20.0,
                  left: 20.0),
              child: new Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: new Card(
                  color: Colors.white,
                  elevation: 4.0,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .28,
              margin: EdgeInsets.all(100.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 1.0,
                    ),
                  ],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/25/36/a5/2536a56bfee899d0e11169a3de15afc2.jpg'))),
            ),
          ],
        ),
      ),
    );
  }
}
