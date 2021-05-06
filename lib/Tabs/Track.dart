import 'package:Ucoe/Screens/Mappage.dart';

import 'package:flutter/material.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          child: Text('Button'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapPage()));
          },
        ),
      ),
    );
  }
}
