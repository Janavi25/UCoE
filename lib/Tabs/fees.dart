import 'dart:io';
import 'dart:math';

import 'package:Ucoe/Model/UserProfile.dart';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/style/colour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class fees extends StatefulWidget {
  @override
  _feesState createState() => _feesState();
}

class _feesState extends State<fees> {
  var uid;
  userprofile localuser;
  DocumentSnapshot doc;
  var document;
  var imageurl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

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

  ele(Color color, icon, head, subtext, check) {
    // var color = Colors.red;
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
    var provider = Provider.of<ProviderData>(context);
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final _screenWidth = _mediaQueryData.size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(provider.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return loadingwidget();
        } else {
          var doc = snapshot.data;
          return FeesPage(
              doc['userPhoto'],
              doc['FeesPaid'],
              doc['Fees'],
              doc['location'],
              doc['classroom'],
              doc['uid'],
              doc['name'],
              doc['phone']);
        }
      },
    );
  }

  Widget FeesPage(
      userPhoto, FeesPaid, Fees, location, classroom, Uid, name, phone) {
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
                      FeesPaid == 1
                          ? Container()
                          : Container(
                              height: 128,
                              width: 500,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 5),
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
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DialogBoxconfirmation(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      alignment: Alignment.center,
                                      width: 70,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        border: Border.all(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
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
                      FeesPaid == 1 ? Colors.green : Colors.red,
                      Icons.account_balance_wallet_outlined,
                      "Bus Fees Paid",
                      "Your bus ID will be generated \n once the admin Approves",
                      false),
                  ele(
                      FeesPaid == 1 ? Colors.green : Colors.red,
                      Icons.error_outline,
                      "On Hold",
                      "Waiting for Admin to Approve",
                      false),
                  ele(
                      Fees == 1 ? Colors.green : Colors.red,
                      Icons.verified_outlined,
                      "Approved",
                      "Your Bus ID is generated",
                      false),
                  Fees == 1
                      ? IdCard(userPhoto, FeesPaid, Fees, location, classroom,
                          Uid, name, phone)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget IdCard(
      userPhoto, FeesPaid, Fees, location, classroom, Uid, name, phone) {
    // return Container(
    //   alignment: Alignment.topCenter,
    //   padding: new EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
    //   child: new Container(
    //     height: 200.0,
    //     width: MediaQuery.of(context).size.width,
    //     child: new Card(
    //       margin: EdgeInsets.only(bottom: 20),
    //       color: Colors.blue[50],
    //       elevation: 4.0,
    //       child: ListView(
    //         children: [
    //           Container(
    //             height: 40,
    //             margin: EdgeInsets.only(top: 20, left: 20, right: 20),
    //             // child: Slider(),
    //             child: Image(
    //               image: NetworkImage(
    //                   "https://image3.mouthshut.com/images/imagesp/925769502s.png"),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(top: 20, left: 30, right: 30),
    //             child: Column(
    //               children: [
    //                 Container(
    //                   margin: EdgeInsets.only(top: 0),
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "Name:",
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(left: 5),
    //                         child: Text(localuser.name),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(top: 5),
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "Class:",
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(left: 5),
    //                         child: Text(localuser.classroom),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(top: 5),
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "Phone Number:",
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(left: 5),
    //                         child: Text(localuser.phone),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: EdgeInsets.only(top: 5),
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "Location:",
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(left: 5),
    //                         child: Text(localuser.location),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Container(
      alignment: Alignment.topCenter,
      padding: new EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
      child: new Container(
        height: 250.0,
        width: MediaQuery.of(context).size.width,
        child: new Card(
          margin: EdgeInsets.only(bottom: 20),
          color: Colors.blue[50],
          elevation: 4.0,
          child: ListView(
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                // child: Slider(),
                child: Image(
                  image: NetworkImage(
                      "https://image3.mouthshut.com/images/imagesp/925769502s.png"),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Text(
                                "Name:",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(name),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(classroom),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(phone),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(location),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 5, left: 10),
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  userPhoto,
                                )),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
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
              msg: 'Image sent ',
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

  void DialogBoxconfirmation(context) {
    var baseDialog = AlertDialog(
      title: new Text(
        "Warning",
        // style: txt.andika,
      ),
      content: Container(
        child: Text(
          'Are you sure you paid the fees?  ',
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
            FirebaseFirestore.instance
                .collection('users')
                .doc(saveuid)
                .update({'CheckFees': 0, 'FeesPaid': 1}).then((value) {
              // uploadImage();
              Dialogimage(context);
              // Fluttertoast.showToast(
              //     msg: 'Fees Request Sent to admin Please Wait for sometime.',
              //     timeInSecForIosWeb: 2,
              //     textColor: Colors.white,
              //     backgroundColor: Colors.indigo[900],
              //     gravity: ToastGravity.BOTTOM);
            }).catchError((e) {
              Fluttertoast.showToast(
                  msg: 'Error Updating Fees, Please try again after sometime.',
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  backgroundColor: Colors.indigo[900],
                  gravity: ToastGravity.BOTTOM);
            });
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void Dialogimage(context) {
    var baseDialog = AlertDialog(
      title: new Text(
        "ID Image",
        // style: txt.andika,
      ),
      content: Container(
        child: Text(
          'Note: you can\'t change the image later. ',
          // style: txt.andikasmall,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          // color: color.theme1,
          child: new Text(
            "ok",
            //  style: txt.lailaverysmall
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String saveuid = prefs.getString('uid');
            uploadImage();

            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  func() async {}
  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   uid = prefs.getString('uid');
  //   doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   print(doc.data);
  //   setState(() {
  //     localuser = userprofile.fromDocument(doc);
  //   });
  //   print(localuser.email);
  // }
}
