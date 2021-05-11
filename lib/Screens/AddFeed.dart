import 'dart:io';
import 'dart:math';

import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/style/decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addfeed extends StatefulWidget {
  @override
  _AddfeedState createState() => _AddfeedState();
}

class _AddfeedState extends State<Addfeed> {
  var imageurl = '';

  TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff19196f),
        title: Text('Post'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(provider.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var doc = snapshot.data;
            return FeedAddUI(doc['name'], doc['uid'], doc['email'],
                doc['Photo'], doc['classroom']);
          }
        },
      ),
    );
  }

  FeedAddUI(name, uid, email, Photo, classroom) {
    return ListView(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(Photo), fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    classroom,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  ),
                )
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(10),
          height: 380,
          width: double.infinity,
          child: TextFormField(
            maxLines: 100,
            controller: _text,
            // style: TextStyle(),
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 20),
                hintText: 'What do you want to talk about?',
                border: InputBorder.none),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  var temp;
                  setState(() {
                    temp = _text.text;
                    _text.text = temp + ' #Life at UCoE';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('#Life at UCoE'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var temp;
                  setState(() {
                    temp = _text.text;
                    _text.text = temp + ' #Motivated';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('#Motivated'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var temp;
                  setState(() {
                    temp = _text.text;
                    _text.text = temp + ' #Fun';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('#Fun'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var temp;
                  setState(() {
                    temp = _text.text;
                    _text.text = temp + ' #Tech';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('#Tech'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var temp;
                  setState(() {
                    temp = _text.text;
                    _text.text = temp + ' #Happy';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('#Happy'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var temp;
                  setState(() {
                    temp = _text.text;
                    _text.text = temp + ' #UCoE Rocks';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text('#UCoE Rocks'),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // uploadImage();
                DialogBoxUpload(context, _text.text,
                    imageurl == null ? '' : imageurl, Photo, name);
              },
              child: Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(),
                child: Icon(
                  Icons.send_outlined,
                  size: 30,
                ),
              ),
            ),
          ],
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String saveuid = prefs.getString('uid');
        var snapshot = await _storage
            .ref()
            .child('ID_Image')
            .child(saveuid)
            .child(generateRandomString(200))
            .putFile(file);
        //     .then((val) {
        // Fluttertoast.showToast(
        //     msg: 'Image Selected',
        //     timeInSecForIosWeb: 2,
        //     textColor: Colors.white,
        //     backgroundColor: Color(0xff19196f),
        //     gravity: ToastGravity.SNACKBAR);
        // }).catchError((e) {
        //   Fluttertoast.showToast(
        //       msg: 'Error Selecting Image',
        //       timeInSecForIosWeb: 2,
        //       textColor: Colors.white,
        //       backgroundColor: Color(0xff19196f),
        //       gravity: ToastGravity.SNACKBAR);
        // });

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageurl = downloadUrl;
        });
        Fluttertoast.showToast(
            msg: 'Image Selected',
            timeInSecForIosWeb: 2,
            textColor: Colors.white,
            backgroundColor: Color(0xff19196f),
            gravity: ToastGravity.SNACKBAR);

        // DialogBoxImage(context);
        // FirebaseFirestore.instance.collection('Feeds')
        //     // .doc(saveuid)
        //     .add({'userPhoto': imageurl}).then((value) {
        //   Fluttertoast.showToast(
        //       msg: 'Image sent ',
        //       timeInSecForIosWeb: 2,
        //       textColor: Colors.white,
        //       backgroundColor: Colors.indigo[900],
        //       gravity: ToastGravity.BOTTOM);
        // }).catchError((e) {
        //   Fluttertoast.showToast(
        //       msg: 'Error selecting image',
        //       timeInSecForIosWeb: 2,
        //       textColor: Colors.white,
        //       backgroundColor: Colors.indigo[900],
        //       gravity: ToastGravity.BOTTOM);
        // });

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

  void DialogBoxUpload(context, value, imageurl, userPhoto, name) {
    var baseDialog = AlertDialog(
      title: new Text(
        "Share Post",
        // style: txt.andika,
      ),
      content: Container(
        child: Text(
          'Are you Sure you want to Upload?',
          // style: txt.andikasmall,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.indigo[900],
          child: new Text("Yes", style: TextStyle(color: Colors.white)),
          onPressed: () async {
            if (value == '' || value == null) {
              Fluttertoast.showToast(
                  msg: 'Text Cannot be Empty',
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  backgroundColor: Color(0xff19196f),
                  gravity: ToastGravity.SNACKBAR);
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String saveuid = prefs.getString('uid');
              // String createRoom = getRoomId(saveuid, uuid);
              FirebaseFirestore.instance.collection('Feed').doc(value).set({
                'text': value,
                'name': name,
                'image': imageurl == '' ? '' : imageurl,
                'time': Timestamp.now().toString(),
                'uid': saveuid,
                'userPhoto': userPhoto,
                'DateTime': DateTime.now().toString()
              }).then((value) {
                _text.text = '';
                print('Photo Uploaded');
                Fluttertoast.showToast(
                    msg: 'Post Shared ✅',
                    timeInSecForIosWeb: 2,
                    textColor: Colors.white,
                    backgroundColor: Color(0xff19196f),
                    gravity: ToastGravity.SNACKBAR);
              }).catchError((e) {
                Fluttertoast.showToast(
                    msg: 'Error Uploading Image',
                    timeInSecForIosWeb: 2,
                    textColor: Colors.white,
                    backgroundColor: Color(0xff19196f),
                    gravity: ToastGravity.SNACKBAR);
              });
            }

            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void DialogBoxImage(context) {
    var baseDialog = AlertDialog(
      title: new Text(
        "Upload Image",
        // style: txt.andika,
      ),
      content: Container(
        child: Text(
          'Enter Text and then Press Image Add Button to Enter Text. ',
          // style: txt.andikasmall,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          // color: color.theme1,
          child: new Text(
            "Yes",
            //  style: txt.lailaverysmall
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String saveuid = prefs.getString('uid');
            // String createRoom = getRoomId(saveuid, uuid);
            FirebaseFirestore.instance.collection('users').doc(saveuid).update({
              'userPhoto': imageurl,
            }).then((value) {
              print('Photo Uploaded');
              Fluttertoast.showToast(
                  msg: 'Image Uploaded',
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  backgroundColor: Color(0xff19196f),
                  gravity: ToastGravity.SNACKBAR);
            }).catchError((e) {
              Fluttertoast.showToast(
                  msg: 'Error Uploading Image',
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  backgroundColor: Color(0xff19196f),
                  gravity: ToastGravity.SNACKBAR);
            });
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }
}
