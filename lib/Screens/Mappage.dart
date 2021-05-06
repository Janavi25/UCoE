import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(19.2798547, 72.8740709);
const LatLng DEST_LOCATION = LatLng(19.3505548, 72.9166332);
// const LatLng DRIVER_LOCATION = LatLng(19.2798547, 72.8740709);
const LatLng CHECK_POINT1 = LatLng(19.2798752, 72.8855163);
String iconb = 'assets/images/checkpt.png';
String icona = 'assets/images/bus.png';
String iconc = 'assets/images/destination_map_marker.png';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  LatLng DRIVER_LOCATION = LatLng(19.2798547, 72.8740709);
  double lat = 0, lng = 0;
  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDfgqTqhA1NkD8KzwgIS6Z0nNwL2JV-cuQ";
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor driverIcon;
  var Data;
  var _mapController;
  BitmapDescriptor destinationIcon;
  BitmapDescriptor checkicon;
  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
    setPolylines();
    const fiveSeconds = const Duration(seconds: 2);
    // _fetchData() is your function to fetch data

    Timer.periodic(fiveSeconds, (Timer t) async {
      setMapPins();
      print('called');
      _mapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    });
    Data = FirebaseFirestore.instance.collection('MiraRoad').snapshots();
  }

  void setSourceAndDestinationIcons() async {
    driverIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), icona);
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), iconb);
    checkicon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), iconb);

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), iconc);
  }

  // @override
  // Widget build(BuildContext context) {
  //   CameraPosition initialLocation = CameraPosition(
  //       zoom: CAMERA_ZOOM,
  //       bearing: CAMERA_BEARING,
  //       tilt: CAMERA_TILT,
  //       target: SOURCE_LOCATION);
  //   return GoogleMap(
  //       myLocationEnabled: true,
  //       compassEnabled: true,
  //       tiltGesturesEnabled: false,
  //       markers: _markers,
  //       polylines: _polylines,
  //       mapType: MapType.normal,
  //       initialCameraPosition: initialLocation,
  //       onMapCreated: onMapCreated);
  // }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);
    return SafeArea(
        child: Container(
      child: StreamBuilder(
        stream: Data,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data.docs.map<Widget>((document) {
              // return Text(document['UserName']);
              // lat = document['latitude'];
              // lng = document['longitude'];
              // DRIVER_LOCATION = LatLng(lat, lng);
              return GooglePage(
                document['latitude'],
                document['longitude'],
              );
            }).toList(),
          );
        },
      ),
    ));
  }

  Widget GooglePage(var latp, var lonp) {
    DRIVER_LOCATION = LatLng(latp, lonp);

    lat = latp;
    lng = lonp;

    CameraPosition initialLocation = CameraPosition(
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
      target: LatLng(latp, lonp),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          // onCameraMove: (),
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    // controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
    setState(() {
      _mapController = controller;
      _mapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    });
  }

  void setMapPins() {
    setState(() {
      // _mapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));

      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon));
      _markers.add(Marker(
          markerId: MarkerId('driverPin'),
          position: DRIVER_LOCATION,
          icon: driverIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: destinationIcon));

      _markers.add(Marker(
          markerId: MarkerId('Bus Top'),
          position: CHECK_POINT1,
          icon: checkicon));
    });
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude,
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude);
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}

// class Utils {
//   static String mapStyles = '''[
//   {
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.icon",
//     "stylers": [
//       {
//         "visibility": "off"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#616161"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.text.stroke",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "featureType": "administrative.land_parcel",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#bdbdbd"
//       }
//     ]
//   },
//   {
//     "featureType": "poi",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#eeeeee"
//       }
//     ]
//   },
//   {
//     "featureType": "poi",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#757575"
//       }
//     ]
//   },
//   {
//     "featureType": "poi.park",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#e5e5e5"
//       }
//     ]
//   },
//   {
//     "featureType": "poi.park",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   },
//   {
//     "featureType": "road",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#ffffff"
//       }
//     ]
//   },
//   {
//     "featureType": "road.arterial",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#757575"
//       }
//     ]
//   },
//   {
//     "featureType": "road.highway",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#dadada"
//       }
//     ]
//   },
//   {
//     "featureType": "road.highway",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#616161"
//       }
//     ]
//   },
//   {
//     "featureType": "road.local",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   },
//   {
//     "featureType": "transit.line",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#e5e5e5"
//       }
//     ]
//   },
//   {
//     "featureType": "transit.station",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#eeeeee"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#c9c9c9"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   }
// ]''';
// }
