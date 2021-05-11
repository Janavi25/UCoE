import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  String _email;
  String _password;
  String _location;
  String _Photo;
  String _phone;
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

  String get location => _location;
  String get Photo => _Photo;
  String get phone => _phone;

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

  void setlocation(String location) {
    _location = location;
    notifyListeners();
    savePreferences();
  }

  void setPhoto(String Photo) {
    _Photo = Photo;
    notifyListeners();
    savePreferences();
  }

  void setphone(String phone) {
    _phone = phone;
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
    prefs.setString('Photo', _Photo);
    prefs.setString('phone', _phone);
    prefs.setString('location', _location);

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
    String phone = prefs.getString('phone');
    String Photo = prefs.getString('Photo');
    String location = prefs.getString('location');

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

    if (phone != null) {
      setphone(phone);
    }
    if (Photo != null) {
      setPhoto(Photo);
    }
    if (location != null) {
      setlocation(location);
    }

    if (color != null) {
      setcolor(color);
    }
  }
}
