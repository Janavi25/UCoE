import 'dart:developer';

import 'package:Ucoe/style/colour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fees extends StatefulWidget {
  @override
  _feesState createState() => _feesState();
}

class _feesState extends State<fees> {
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

  int _radioValue = 3;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  ele(icon, head, subtext, check) {
    var color = Colors.red;
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Column(children: [
              circle(color),
              circle(color),
              circle(color),
              Icon(Icons.verified, color: color, size: 20),
              circle(color),
              circle(color),
              circle(color),
            ]),
            SizedBox(width: 20),
            Container(
              height: 50,
              width: 50,
              child: Icon(icon, color: Colors.black87, size: 50),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  head,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65),
                  child: Text(
                    subtext,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final _screenWidth = _mediaQueryData.size.width;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          top: true,
          child: Container(
            color: Colors.grey[50],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 128,
                        width: 500,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                        // padding: EdgeInsets.all(30),
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey[600],
                                blurRadius: 1.0,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Have you Paid your Bus Fees?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                                new Text(
                                  'yes',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                                new Text(
                                  'No',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: new EdgeInsets.only(
                        top: 20, right: 20.0, left: 20.0, bottom: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Track Your Fees ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ele(
                      Icons.account_balance_wallet_outlined,
                      "Bus Fees Paid",
                      "Your bus ID will be generated \n once the admin Approves",
                      false),
                  ele(Icons.error_outline, "On Hold",
                      "Waiting for Admin to Approve", false),
                  ele(Icons.verified_outlined, "Approved",
                      "Your Bus ID is generated", false),
                  Container(
                    alignment: Alignment.topCenter,
                    padding:
                        new EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
                    child: new Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: new Card(
                        margin: EdgeInsets.only(bottom: 20),
                        color: Colors.blue[50],
                        elevation: 4.0,
                        child: ListView(
                          children: [
                            Container(
                              height: 40,
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              // child: Slider(),
                              child: Image(
                                image: NetworkImage(
                                    "https://image3.mouthshut.com/images/imagesp/925769502s.png"),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 30, right: 30),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Name:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text("Janavi Panchal"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Class:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text("SE"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Phone Number:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text("7045228801"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Location:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text("Mira Road"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
