import 'package:Ucoe/Screens/AddFeed.dart';
import 'package:Ucoe/home/CommentSec.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class life extends StatefulWidget {
  @override
  _lifeState createState() => _lifeState();
}

class _lifeState extends State<life> {
  var suid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences a = await SharedPreferences.getInstance();
    suid = a.getString("uid");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 1.0,
                    ),
                  ],
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text('Explore Life At Ucoe',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Colors.grey[600],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Addfeed()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 250,
                            padding: EdgeInsets.all(7),
                            margin: EdgeInsets.all(7),
                            child: Text(
                              'Tell Us Something ....  ',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey[600])),
                          ),
                          Container(
                            height: 46,
                            child: VerticalDivider(
                              color: Colors.grey[600],
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(
                                // Icons.add_circle_outline,
                                Icons.border_color,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Addfeed()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Feed')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data.docs.map<Widget>((document) {
                      // return Text(document['UserName']);
                      return FeedTile(
                        document['name'],
                        document['userPhoto'],
                        document['DateTime'],
                        document['image'],
                        document.id,
                        document['uid'],
                        document['text'],
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  FeedTile(String name, String userImage, String time, String image, String id,
      String uid, text) {
    // bool liked = false;

    return Container(
        // height: 500,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey[600],
            blurRadius: 1,
            spreadRadius: 0.1,
          ),
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(140),
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(140)),
                          height: 58,
                          width: 60,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0, top: 0, bottom: 0),
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(140)),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      userImage,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, top: 7, right: 10),
                          child: Text(
                            name,
                            style: GoogleFonts.lato(
                                color: Colors.grey[700],
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            time.substring(0, 10),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                                color: Colors.grey[500],
                                fontSize: 11,
                                letterSpacing: 1,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image == ''
                        ? Container()
                        : Container(
                            height: 400,
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              // boxShadow: [
                              //   new BoxShadow(
                              //     color: Colors.grey[600],
                              //     blurRadius: 7.0,
                              //   ),
                              // ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(image),
                              ),
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(text,
                          maxLines: 500,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          )),
                    ),
                  ],
                ),
                // Container(
                //   height: 50,
                //   alignment: Alignment.centerLeft,
                //   margin: EdgeInsets.only(left: 20, right: 20),
                //   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                //   child: Row(children: [
                //     SizedBox(
                //       height: 40,
                //     ),
                //     IconButton(
                //       onPressed: () {},
                //       icon: Icon(
                //         Icons.comment,
                //         color: Colors.indigo[900],
                //       ),
                //     ),
                //   ]),
                // ),
                Container(
                  padding: const EdgeInsets.only(top: 18, right: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CommentSec(post: text)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.only(right: 1.0),
                          child: Image.network(
                            'https://www.searchpng.com/wp-content/uploads/2019/02/Comment-Icon-PNG.png',
                            height: 40,
                          ),
                        ),
                      ),

                      uid == suid
                          ? Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.only(right: 1.0),
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Feed')
                                      .doc(id)
                                      .delete()
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: 'Deleted Post',
                                        timeInSecForIosWeb: 2,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.black,
                                        gravity: ToastGravity.BOTTOM);
                                  }).catchError((e) {
                                    Fluttertoast.showToast(
                                        msg: 'Error Deleting',
                                        timeInSecForIosWeb: 2,
                                        toastLength: Toast.LENGTH_LONG,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.black,
                                        gravity: ToastGravity.SNACKBAR);
                                  });
                                },
                              ),
                            )
                          : Container(),
                      // Text(
                      //   '45',
                      //   style: GoogleFonts.averageSans(
                      //       color: Colors.grey[700],
                      //       fontSize: 22,
                      //       letterSpacing: 1,
                      //       fontWeight: FontWeight.normal),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            // Container(
            //   padding:
            //       EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            //   child: Divider(
            //     height: 1,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ));
  }

  // Tile(
  //   time,
  //   desc,
  //   photo,
  // ) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  //     child: Column(
  //       children: [],
  //     ),
  //   );
  // }
}
