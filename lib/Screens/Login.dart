// import 'package:Ucoe/fcm_item.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:math';

import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/Navigation.dart';
import 'package:Ucoe/style/colour.dart';
import 'package:Ucoe/style/decoration.dart';
import 'package:Ucoe/style/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

colour color = colour();
decoration deco = decoration();
text txt = text();
var imageurl = '';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

// final Map<String, Item> _items = <String, Item>{};
// Item _itemForMessage(Map<String, dynamic> message) {
//   final dynamic data = message['data'] ?? message;
//   final String itemId = data['id'];
//   final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
//     ..status = data['status'];
//   return item;
// }

class _loginState extends State<login> {
  List<Color> colors = [Color(0xFF330867), Color(0xFF30cfd0)];
  int _index = 0;
  var _passwordVisible = true;
  var fuid;
  var uid;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  var provider;
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _phoneCOntroller = new TextEditingController();
  var _chosenvalueClass, _chosenvalueLocation;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //
  //
  // final List<Notification> notifications = [];
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  User user;
  var imageselected = false;
  //
  // initializeFCM() {
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //       _showItemDialog(message);
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       _navigateToItemDetail(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       _navigateToItemDetail(message);
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(
  //           sound: true, badge: true, alert: true, provisional: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  //   _firebaseMessaging.getToken().then((String token) {
  //     assert(token != null);
  //     setState(() {
  //       _homeScreenText = "Push Messaging token: $token";
  //     });
  //     print(_homeScreenText);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    getData();
    directLogin();
    // initializeFCM();
  }

  getData() async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxyyyyyyyyyyyyyyyyyyyyy");
    var user1 = FirebaseAuth.instance.currentUser;
    setState(() {
      user = user1;
      print(user1.uid);
      fuid = user.uid;
    });
    print(fuid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // email = prefs.getString('email');
      // password = prefs.getString('password');
      uid = prefs.getString('uid');
      // colr = prefs.getString('color');
    });
  }

  directLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    if (uid != null) {
      if (uid == fuid) {
        print(fuid);
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navigation()));
      } else {
        // Navigator.of(context).pop();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => login()));
      }
    } else {
      // Navigator.of(context).pop();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    }
  }

  // Widget _buildDialog(BuildContext context, Item item) {
  //   return AlertDialog(
  //     content: Text("Item ${item.itemId} has been updated"),
  //     actions: <Widget>[
  //       FlatButton(
  //         child: const Text('CLOSE'),
  //         onPressed: () {
  //           Navigator.pop(context, false);
  //         },
  //       ),
  //       FlatButton(
  //         child: const Text('SHOW'),
  //         onPressed: () {
  //           Navigator.pop(context, true);
  //         },
  //       ),
  //     ],
  //   );
  // }

  // void _showItemDialog(Map<String, dynamic> message) {
  //   showDialog<bool>(
  //     context: context,
  //     builder: (_) => _buildDialog(context, _itemForMessage(message)),
  //   ).then((bool shouldNavigate) {
  //     if (shouldNavigate == true) {
  //       _navigateToItemDetail(message);
  //     }
  //   });
  // }

  // void _navigateToItemDetail(Map<String, dynamic> message) {
  //   final Item item = _itemForMessage(message);
  //   // Clear away dialogs
  //   Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
  //   if (!item.route.isCurrent) {
  //     Navigator.push(context, item.route);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderData>(context);

    onWillPop() {
      DialogBox2(context);
    }

    return WillPopScope(
        child: Scaffold(
            body: SafeArea(
          top: false,
          bottom: false,
          left: false,
          right: false,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   'img/logobus.png',
                    //   width: 220,
                    //   height: 200,
                    // ),
                    Container(
                      child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/fir-auth-79ef2.appspot.com/o/logobus.png?alt=media&token=eb380ae5-e834-42ce-b097-88f7bd575150"),
                      height: 190,
                      width: 190,
                    ),
                    Tabs(context),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 150),
                      firstChild: Login(context),
                      secondChild: SignUp(context),
                      crossFadeState: _index == 0
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
        onWillPop: onWillPop);
  }

  Widget Login(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 15, right: 15, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.assignment_ind,
                              color: Colors.grey,
                            ),
                            labelText: "Email Id",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent))),
                      ),
                      Divider(color: Colors.grey, height: 8),
                      TextFormField(
                        controller: _passController,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent))),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 140,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_emailController.text != null &&
                          _passController.text != null) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passController.text)
                            .then((value) async {
                          User user = value.user;
                          provider.setemail(_emailController.text);
                          provider.setpassword(_passController.text);
                          provider.setuid(user.uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navigation()));
                        }).catchError((e) {
                          DialogBox(context, e.toString());
                        });
                      } else {
                        DialogBox2(context);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: colors),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                            child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
          ),
        ],
      ),
    );
  }

//yaha se register karo
  Widget SignUp(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15, right: 15, bottom: 20),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _namecontroller,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    labelText: "Name",
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),
                              Divider(color: Colors.grey, height: 8),
                              TextFormField(
                                controller: _phoneCOntroller,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                    ),
                                    labelText: "Phone Number",
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),
                              Divider(color: Colors.grey, height: 8),
                              Container(
                                  // width: 0,
                                  padding: EdgeInsets.only(left: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 12),
                                        child: DropdownButton<String>(
                                          focusColor: Colors.white,
                                          underline: Container(),
                                          value: _chosenvalueLocation,
                                          //elevation: 5,
                                          style: TextStyle(color: Colors.white),
                                          // iconEnabledColor: Colors.black,
                                          items: <String>[
                                            'Mira Road',
                                            'Vasai',
                                            'Thane',
                                            'Borivali',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "Select Location",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              _chosenvalueLocation = value;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //       prefixIcon: Icon(
                              //         Icons.location_pin,
                              //         color: Colors.grey,
                              //       ),
                              //       labelText: "Location",
                              //       labelStyle: TextStyle(color: Colors.black87),
                              //       enabledBorder: UnderlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.transparent)),
                              //       focusedBorder: UnderlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.transparent))),
                              // ),
                              Divider(color: Colors.grey, height: 8),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.assignment_ind,
                                      color: Colors.grey,
                                    ),
                                    labelText: "Email ID",
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),
                              Divider(color: Colors.grey, height: 8),
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //       prefixIcon: Icon(
                              //         Icons.school,
                              //         color: Colors.grey,
                              //       ),
                              //       labelText: "Class",
                              //       labelStyle: TextStyle(color: Colors.black87),
                              //       enabledBorder: UnderlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.transparent)),
                              //       focusedBorder: UnderlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Colors.transparent))),
                              // ),
                              Container(
                                  // width: 0,
                                  padding: EdgeInsets.only(left: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.school,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 12),
                                        child: DropdownButton<String>(
                                          focusColor: Colors.white,
                                          underline: Container(),
                                          value: _chosenvalueClass,
                                          //elevation: 5,
                                          style: TextStyle(color: Colors.white),
                                          // iconEnabledColor: Colors.black,
                                          items: <String>[
                                            'FE',
                                            'SE',
                                            'TE',
                                            'BE',
                                            'College Staff/Faculty Members'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "Select Year",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              _chosenvalueClass = value;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                              Divider(color: Colors.grey, height: 8),
                              TextFormField(
                                controller: _passController,
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        }),
                                    labelText: "Password",
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),

                              Divider(
                                color: Colors.transparent,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 385,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              print(
                                  'ontapooooooooooooooooooooooooooooooooooooo');
                              if (_emailController.text != null &&
                                  _passController.text != null &&
                                  _namecontroller.text != null &&
                                  _phoneCOntroller.text != null &&
                                  _chosenvalueLocation != null &&
                                  _chosenvalueClass != null) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passController.text)
                                    .then((value) async {
                                  User user = value.user;
                                  // print(_nameController.text);

                                  print('you clicked login');
                                  if (user.uid != null) {
                                    await FirebaseFirestore.instance
                                        .collection('/users')
                                        .doc(user.uid)
                                        .set({
                                      'uid': user.uid,
                                      'email': _emailController.text,
                                      'phone': _phoneCOntroller.text,
                                      'CheckFees': 0,
                                      'Fees': 0,
                                      'FeesPaid': 0,
                                      'changeYear': false,
                                      'checkFees': 0,
                                      'classroom': _chosenvalueClass,
                                      'userPhoto':
                                          'https://www.cybersport.ru/assets/img/no-photo/user.png',
                                      'location': _chosenvalueLocation,
                                      'name': _namecontroller.text,
                                      'password': _passController.text,
                                      'Photo': imageurl == ''
                                          ? 'https://www.cybersport.ru/assets/img/no-photo/user.png'
                                          : imageurl,
                                    }).then((result) {
                                      print("User Added");
                                      provider.setemail(_emailController.text);
                                      provider
                                          .setpassword(_passController.text);
                                      provider.setuid(user.uid);
                                      provider
                                          .setlocation(_chosenvalueLocation);
                                      provider.setPhoto(imageurl);
                                      provider.setphone(_phoneCOntroller.text);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Navigation()));
                                    }).catchError((e) {
                                      print("Error: $e" + "!");
                                      print(
                                          'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                                      DialogBox(context, e.toString());
                                    });
                                  } else {
                                    DialogBox(context, 'Error Authentication');
                                  }
                                }).catchError((e) {
                                  DialogBox(context, e.toString());
                                });
                              } else {
                                print(
                                    'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
                                DialogBox2(context);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: colors,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Center(
                                    child: Text(
                                  "SIGNUP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  uploadImage() async {
    // imageurl = "";
    print('This Code Will Run');
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('UserImage')
            // .child(roomId)
            .child(generateRandomString(200))
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageurl = downloadUrl;
        });
        DialogBoxImage(context);

        // // FirebaseFirestore.instance.collection('Feed').add({
        // //   'Photo': imageurl,
        // //   'Head': heading.text,
        // //   'body': bodymaterial.text,
        // // });

        // print(imageurl);
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  void DialogBox(context, String error) {
    var baseDialog = AlertDialog(
      title: new Text("Login Failed"),
      content: Container(
        child:
            Text('Please try Again After Sometime or Enter Valid Credentials'),
        // Text(error),
      ),
      actions: <Widget>[
        FlatButton(
          color: color.themeA,
          child: new Text("Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void DialogLoading(context, val) {
    var baseDialog = AlertDialog(
      title: new Text("Login Failed"),
      content: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(
                backgroundColor: color.themeA,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: color.themeA,
          child: new Text("Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void DialogBoxImage(context) {
    var baseDialog = AlertDialog(
      title: new Text("Image"),
      content: Container(
        child: Text('Image Uploaded'),
      ),
      actions: <Widget>[
        FlatButton(
          color: color.themeA,
          child: new Text("ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void DialogBox2(context) {
    var baseDialog = AlertDialog(
      title: new Text("Warning"),
      content: Container(
        child: Text('Enter Proper Data'),
      ),
      actions: <Widget>[
        FlatButton(
          color: color.themeA,
          child: new Text("Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  Widget Tabs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.12),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                        color: _index == 0 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Existing",
                        style: TextStyle(
                            color: _index == 0 ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: _index == 0
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ))),
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                        color: _index == 1 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New",
                        style: TextStyle(
                            color: _index == 1 ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: _index == 1
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ))),
                onTap: () {
                  setState(() {
                    _index = 1;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget buildNotification(Notification notification) {
  //   return ListTile(
  //     title: Text(
  //       notification.title,
  //       style: TextStyle(
  //         color: notification.color,
  //       ),
  //     ),
  //     subtitle: Text(notification.body),
  //   );
  // }
}

// class Notification {
//   final String title;
//   final String body;
//   final Color color;
//   const Notification(
//       {@required this.title, @required this.body, @required this.color});
// }
