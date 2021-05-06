import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  String _email;
  String _password;
  String _uid;
  Color _themeA;
  Color _themeB;
  Color _themeC;
  String _color;

  ProviderData() {
    _email = 'Email Id';
    _password = 'Password';
    _uid = 'uid';
    _themeA = Color(0xffff3985);
    _themeB = Color(0xffff858d);
    _themeC = Color(0xffff4f86);
    _color = 'a';
    loadPreferences();
  }

  //Getters
  String get email => _email;
  String get password => _password;
  String get uid => _uid;
  String get color => _color;

  Color get themeA => _themeA;
  Color get themeB => _themeB;
  Color get themeC => _themeC;

  void setcolor(String color) {
    _color = color;
    notifyListeners();
    savePreferences();
  }

  void setemail(String email) {
    _email = email;
    notifyListeners();
    savePreferences();
  }

  void setpassword(String password) {
    _password = password;
    notifyListeners();
    savePreferences();
  }

  void setuid(String uid) {
    _uid = uid;
    notifyListeners();
    savePreferences();
  }

  void setThemeA(Color color) {
    _themeA = color;
    notifyListeners();
    savePreferences();
  }

  void setThemeB(Color color) {
    _themeA = color;
    notifyListeners();
    savePreferences();
  }

  void setThemeC(Color color) {
    _themeA = color;
    notifyListeners();
    savePreferences();
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
    prefs.setString('password', _password);
    prefs.setString('uid', _uid);
    // prefs.setString('themeA', 'a');
    // prefs.setString('themeB', 'b');
    // prefs.setString('themeC', 'c');
    prefs.setString('color', _color);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    String password = prefs.getString('password');
    String uid = prefs.getString('uid');
    String color = prefs.getString('color');
    // String themeB = prefs.getString('themeB');
    // String themeC = prefs.getString('themeC');

    if (email != null) {
      setemail(email);
    }
    if (password != null) {
      setpassword(password);
    }
    if (uid != null) {
      setuid(uid);
    }
    if (color != null) {
      setcolor(color);
    }
  }
}
