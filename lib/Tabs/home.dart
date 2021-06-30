import 'package:Ucoe/Model/UserProfile.dart';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:Ucoe/Screens/busFee.dart';
import 'package:Ucoe/Tabs/Track.dart';
import 'package:Ucoe/home/announcement.dart';
import 'package:Ucoe/home/event.dart';
import 'package:Ucoe/home/life.dart';
import 'package:Ucoe/style/decoration.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Ucoe/Screens/Navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NavigationState nav = NavigationState(n: 0);

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var uid;
  userprofile localuser;
  DocumentSnapshot doc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  final List<Widget> imageSliders = [
    'https://cache.careers360.mobi/media/presets/720X480/colleges/social-media/media-gallery/8786/2019/2/18/Campus%20View%20of%20Universal%20College%20of%20Engineering%20Thane_Campus-View.jpg',
    'https://universalcollegeofengineering.edu.in/wp-content/uploads/2019/07/workshop-img01.jpg',
    'https://scontent.fbom3-1.fna.fbcdn.net/v/t1.6435-9/124269549_3654313551273903_8687996117429977018_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=730e14&_nc_ohc=S0XHOETdtyUAX9Diy6I&_nc_ht=scontent.fbom3-1.fna&oh=8f0fefc0419f97d6fa2ac8c530e45bcd&oe=60BA6758',
    'https://universalcollegeofengineering.edu.in/wp-content/uploads/2019/07/open-air-class.jpg',
    'https://scontent.fbom3-1.fna.fbcdn.net/v/t1.6435-9/124864058_3657255597646365_3780648004606427752_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=730e14&_nc_ohc=0ZApxQnjzocAX8L9aE0&_nc_ht=scontent.fbom3-1.fna&oh=4f97b8b0f83ba2fd6c0ea45987c13c67&oe=60BAF2D2',
    // 'https://www.thoughtco.com/thmb/FbEXn4OLxXdsPGIddf15uOAUDWo=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/gender-equality-165793283x-56aa236b3df78cf772ac8752.jpg'
  ]
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(2.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 2000.0,
                        height: 200,
                      )
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loadingwidget();
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[50],
              body: ListView(
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
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(top: 10),
                    child: Slider(),
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => event()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    height: 130,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(20.0),
                                            topRight:
                                                const Radius.circular(20.0))),
                                    child: Image(
                                      image: NetworkImage(
                                          "https://img.icons8.com/bubbles/2x/speaker.png"),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(20.0),
                                            bottomRight:
                                                const Radius.circular(20.0))),
                                    child: Text(
                                      'Upcoming Events',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => busfees()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 130,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(20.0),
                                            topRight:
                                                const Radius.circular(20.0))),
                                    child: Image(
                                      image: NetworkImage(
                                        "https://img.icons8.com/bubbles/2x/money.png",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 150,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(20.0),
                                            bottomRight:
                                                const Radius.circular(20.0))),
                                    child: Text(
                                      'Bus Fee Structure',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => life()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    height: 130,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(20.0),
                                            topRight:
                                                const Radius.circular(20.0))),
                                    child: Image(
                                      image: NetworkImage(
                                        "https://www.freepngvectors.com/wp-content/uploads/2020/12/education-group-icon11.png",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 150,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(20.0),
                                            bottomRight:
                                                const Radius.circular(20.0))),
                                    child: Text(
                                      'Life at UCoE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => announcement()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 130,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow[50],
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[600],
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(20.0),
                                            topRight:
                                                const Radius.circular(20.0))),
                                    child: Image(
                                      image: NetworkImage(
                                        "https://img.icons8.com/bubbles/2x/appointment-reminders.png",
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  announcement()));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            new BoxShadow(
                                              color: Colors.grey[600],
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  const Radius.circular(20.0),
                                              bottomRight:
                                                  const Radius.circular(20.0))),
                                      child: Text(
                                        'Announcement',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }

  Widget loadingwidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print(doc.data);
    setState(() {
      localuser = userprofile.fromDocument(doc);
    });
    print(localuser.email);
  }

  Widget Slider() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: imageSliders,
      ),
    );
  }
}
