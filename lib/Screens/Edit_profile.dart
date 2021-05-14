import 'dart:io';
import 'dart:math';

import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/Navigation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editprofile extends StatefulWidget {
  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  FirebaseAuth _auth;
  User user;
  var _chosenvalueClass, _chosenvalueLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _editname = TextEditingController();
  final TextEditingController _editphoto = TextEditingController();
  final TextEditingController _editphone = TextEditingController();
  // final TextEditingController _editlocation = TextEditingController();
  // final TextEditingController _editclass = TextEditingController();
  String test, ImageUrl = "https://i.ibb.co/QdQ3CQK/undraw-wishes-icyp.png";
  var imageurl = '';

  @override
  void initState() {
    super.initState();

    // getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Navigation()));
          },
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(provider.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return loadingwidget();
            } else {
              var doc = snapshot.data;
              return Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {},
                    child: ListView(
                      children: [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageurl == ''
                                        ? NetworkImage(doc['Photo'])
                                        : NetworkImage(
                                            imageurl,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: Colors.green,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          uploadImage();
                                        },
                                      ))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        // buildTextField("Full Name", localuser.Name, false),
                        // buildTextField("About", localuser.aboutus, false),
                        // buildTextField("Phone", localuser.phone, false),
                        // buildTextField("City", localuser.city, false),
                        // buildTextField("Occupation", localuser.occupation, false),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                            controller: _editname,
                            // onChanged: (value) {
                            //   setState(() {
                            //     _editname.text = value;
                            //   });
                            // },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Name",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: doc['name'],
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _editphone,
                            onChanged: (value) {
                              setState(() {
                                // EditPhone = value;
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Phone",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: doc['phone'],
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Select Year",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Select Location",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlineButton(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Navigation()));
                              },
                              child: Text("CANCEL",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.black)),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  updatechanges(
                                      doc['name'],
                                      doc['phone'],
                                      doc['location'],
                                      doc['Photo'],
                                      doc['classroom']);
                                }
                              },
                              color: Color(0xFFEF5350),
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  // Widget Loader() {
  //   return StreamBuilder(
  //     stream:
  //         FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (!snapshot.hasData) {
  //         return loadingwidget();
  //       }
  //       return profilepage();
  //     },
  //   );
  // }

  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String saveuid = prefs.getString('uid');
        var snapshot = await _storage
            .ref()
            .child('ID_Image')
            .child(saveuid)
            .child(generateRandomString(200))
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageurl = downloadUrl;
        });
        // DialogBoxImage(context);
        FirebaseFirestore.instance
            .collection('users')
            .doc(saveuid)
            .update({'userPhoto': imageurl}).then((value) {
          Fluttertoast.showToast(
              msg: 'Image Selected ',
              timeInSecForIosWeb: 2,
              textColor: Colors.white,
              backgroundColor: Colors.indigo[900],
              gravity: ToastGravity.BOTTOM);
        }).catchError((e) {
          Fluttertoast.showToast(
              msg: 'Error selecting image',
              timeInSecForIosWeb: 2,
              textColor: Colors.white,
              backgroundColor: Colors.indigo[900],
              gravity: ToastGravity.BOTTOM);
        });
        // // FirebaseFirestore.instance.collection('Feed').add({
        // //   'Photo': imageurl,
        // //   'Head': heading.text,
        // //   'body': bodymaterial.text,
        // // });

        print(imageurl);
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

  updatechanges(name, phone, location, Photo, classr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saveuid = prefs.getString('uid');
    await FirebaseFirestore.instance.collection("users").doc(saveuid).update({
      'name': _editname.text == null || _editname.text == ''
          ? name
          : _editname.text,
      'phone': _editphone.text == null || _editphone.text == ''
          ? phone
          : _editphone.text,
      'location': _chosenvalueLocation == null || _chosenvalueLocation == ''
          ? location
          : _chosenvalueLocation,
      'Photo': imageurl == '' ? Photo : imageurl,
      'classroom': _chosenvalueClass == null || _chosenvalueClass == ''
          ? classr
          : _chosenvalueClass
    }).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigation()));
      Fluttertoast.showToast(
          msg: "Profile Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }).catchError((e) {
      print("GalatHoGaya");
      Fluttertoast.showToast(
          msg: "Please Try Again After Sometime",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    });
    Navigator.of(context).pop();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Navigation()));
  }
}
