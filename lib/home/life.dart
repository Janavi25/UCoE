import 'package:flutter/material.dart';

class life extends StatefulWidget {
  @override
  _lifeState createState() => _lifeState();
}

class _lifeState extends State<life> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 1.0,
                    ),
                  ],
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
