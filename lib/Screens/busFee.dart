import 'package:Ucoe/Screens/Navigation.dart';
import 'package:flutter/material.dart';

class busfees extends StatefulWidget {
  @override
  _busfeesState createState() => _busfeesState();
}

class _busfeesState extends State<busfees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Navigation()));
          },
        ),
        title: Text('Bus Fees Structure'),
      ),
      body: ListView(
        children: [
          Container(
            height: 120,
            margin: EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Card(
              elevation: 3.0,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Icon(
                      Icons.directions_bus,
                      color: Colors.red[400],
                      size: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 58),
                          child: Text(
                            'Vasai',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 50),
                          child: Text(
                            '4 Buses',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Text(
                            'Rs 19,000',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[600],
                              fontSize: 16,
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
          Container(
            height: 120,
            margin: EdgeInsets.only(right: 10, left: 10, top: 3),
            child: Card(
              elevation: 3.0,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Icon(
                      Icons.directions_bus,
                      color: Colors.yellow[800],
                      size: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Text(
                            'Mira Bhayandar',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 80),
                          child: Text(
                            '3 Buses',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 70),
                          child: Text(
                            'Rs 21,000',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[600],
                              fontSize: 16,
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
          Container(
            height: 120,
            margin: EdgeInsets.only(right: 10, left: 10, top: 3),
            child: Card(
              elevation: 3.0,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Icon(
                      Icons.directions_bus,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 38),
                          child: Text(
                            'Borivali',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 45),
                          child: Text(
                            '3 Buses',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 35),
                          child: Text(
                            'Rs 21,000',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[600],
                              fontSize: 16,
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
          Container(
            height: 120,
            margin: EdgeInsets.only(right: 10, left: 10, top: 3),
            child: Card(
              elevation: 3.0,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Icon(
                      Icons.directions_bus,
                      color: Colors.blue[600],
                      size: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 58),
                          child: Text(
                            'Thane',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 50),
                          child: Text(
                            '4 Buses',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Text(
                            'Rs 20,000',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[600],
                              fontSize: 16,
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
      ),
    );
  }
}
