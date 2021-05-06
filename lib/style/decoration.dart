import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class decoration {
  BoxDecoration shadow = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
            blurRadius: 0.6,
            color: Colors.grey,
            offset: Offset(0.8, 0.1),
            spreadRadius: 0.6)
      ]);

  BoxDecoration radius = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));
}
