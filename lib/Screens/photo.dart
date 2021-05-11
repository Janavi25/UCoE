import 'package:flutter/material.dart';

class photo extends StatefulWidget {
  String url;

  photo({@required this.url});
  @override
  _photoState createState() => _photoState(url: url);
}

class _photoState extends State<photo> {
  String url;
  _photoState({@required this.url});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
