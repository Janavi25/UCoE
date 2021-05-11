import 'dart:io';
import 'dart:math';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var imageurl;
var color = Color(0xFF19196f);
String uid;

class CommentSec extends StatefulWidget {
  String post;
  // String roomId;
  // String Name, Photo, Email;
  // String imageurl;
  // ChatSec(
  //     {@required this.uuid,
  //     @required this.roomId,
  //     this.Name,
  //     this.Photo,
  //     this.Email
  //     });

  CommentSec({@required this.post});

  @override
  // _ChatScreenState createState() => _ChatScreenState(
  //     uuid: uuid,
  //     roomId: roomId,
  //     Name: this.Name,
  //     Photo: this.Photo,
  //     Email: this.Email
  //     );

  _CommentSecState createState() => _CommentSecState(post: post);
}

class _CommentSecState extends State<CommentSec> {
  // String uuid;
  // String roomId;
  // String Name, Photo, Email;
  // _ChatScreenState({this.uuid, this.roomId, this.Name, this.Photo, this.Email});
  var post;
  _CommentSecState({@required this.post});
  var Data;

  var Chats;
  // BuildContext contxt;
  String message;

  TextEditingController chatController = TextEditingController();
  // var QuerySnapshot;
  var chatsdata;
  @override
  void initState() {
    super.initState();

    getDataShared();
    chatsdata = FirebaseFirestore.instance
        .collection('Feeds')
        .doc(post)
        .collection('Comments')
        .snapshots();
    print(uid);
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    // Data = FirebaseFirestore.instance.collection('Users').snapshots();
    // Chats=FirebaseFirestore.instance.collection('').snapshots();
  }

  getDataShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    onWillPop() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   backgroundColor: color,
          //   title: Text('Message'),
          // ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(provider.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var doc = snapshot.data;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Flexible(
                      child: Container(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Feed')
                              .doc(post)
                              .collection('Comments')
                              .orderBy('time', descending: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView(
                                reverse: true,
                                children:
                                    snapshot.data.docs.map<Widget>((document) {
                                  // return Text(document['UserName']);
                                  return MessageTile(
                                      document['Photo'],
                                      document['Message'],
                                      document['send'],
                                      document.id,
                                      document['name']);
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    chatControls(doc['Photo'], doc['name']),
                  ],
                );
              }
            },
          ),
        ),
        onWillPop: onWillPop);
  }

  void displayBottomSheet(BuildContext cont) {
    showModalBottomSheet(
        // backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: cont,
        builder: (ctx) {
          return Container(
            height: 200,
          );
        });
  }

  Widget MessageTile(
      String Photo, String Message, String send, String id, String name) {
    return GestureDetector(
      onLongPress: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var suid = prefs.getString('uid');
        if (suid == send) {
          DialogBoxDelete(context, id);
        } else {
          print(suid);
          print(send);
          print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        }
      },
      child: Container(
        child: Row(
          children: [
            Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.all(5),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(140)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    Photo,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  send == uid ? 'you' : name,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  Message,
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void DialogBoxDelete(context, id) {
    var baseDialog = AlertDialog(
      title: new Text(
        "Delete",
        // style: txt.andika,
      ),
      content: Container(
        child: Text(
          'You Want to Delete Message?',
          // style: txt.andikasmall,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: color,
          child: new Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Feed')
                .doc(post)
                .collection('Comments')
                .doc(id)
                .delete();
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  // Widget MessageTile(
  //     String Photo, String Message, String send, String id, String name) {
  //   return Container(
  //     alignment: uid == send ? Alignment.centerRight : Alignment.centerLeft,
  //     child: GestureDetector(
  //       onLongPress: () {
  //         // DialogBoxDelete(context, id, roomId);
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: uid == send ? color : Colors.green,
  //             borderRadius: BorderRadius.all(Radius.circular(14))),
  //         padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
  //         margin: EdgeInsets.only(
  //             left: uid == send ? 60 : 4,
  //             right: uid == send ? 4 : 60,
  //             top: 4,
  //             bottom: 4),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
  //               child: Text(Message,
  //                   maxLines: 100,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(fontSize: 16, color: Colors.white)),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

// alignment: Sender == uid
//                     ? Alignment.centerRight
//                     : Alignment.centerLeft,
  chatControls(PhotoUser, name) {
    return Container(
      color: color,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: chatController,
              textInputAction: TextInputAction.send,
              onChanged: (input) {
                setState(() {
                  message = input;
                });
              },
              onFieldSubmitted: (value) async {
                if (chatController.text == "") {
                } else {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var suid = prefs.getString('uid');
                  FirebaseFirestore.instance
                      .collection('Feed')
                      .doc(post)
                      .collection('Comments')
                      .add({
                    'Message': chatController.text,
                    'send': suid,
                    'time': Timestamp.now().toString(),
                    'Photo': PhotoUser,
                    'name': name
                  }).then((value) {
                    print('message sent');
                    chatController.text = '';
                  }).catchError((e) {
                    print('message not sent');
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Say Hi ...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (chatController.text == "") {
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var suid = prefs.getString('uid');
                FirebaseFirestore.instance
                    .collection('Feed')
                    .doc(post)
                    .collection('Comments')
                    .add({
                  'Message': chatController.text,
                  'send': suid,
                  'time': Timestamp.now().toString(),
                  'Photo': PhotoUser,
                  'name': name
                }).then((value) {
                  print('message sent');
                  chatController.text = '';
                }).catchError((e) {
                  print('message not sent');
                });
              }
            },
            child: Opacity(
              opacity: 1,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.indigo[400], shape: BoxShape.circle),
                child: Icon(
                  Icons.send,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void displayBottomSheet(BuildContext cont, String id) {
  showModalBottomSheet(
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: cont,
      builder: (ctx) {
        return Container(
          height: 200,
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {},
              )
            ],
          ),
        );
      });
}
