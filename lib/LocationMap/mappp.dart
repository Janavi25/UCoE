import 'dart:async';
import 'package:Ucoe/Provider/ProviderData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

const LatLng SOURCE_LOCATION = LatLng(19.2798547, 72.8740709);
const LatLng DEST_LOCATION = LatLng(19.3505548, 72.9166332);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;
String iconb = 'assets/images/checkpt.png';
String icona = 'assets/images/bus.png';
String iconc = 'assets/images/destination_map_marker.png';

class MapPage extends StatefulWidget {
  // SubCategory subCategory;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  double pinPillPosition = PIN_VISIBLE_POSITION;
  LatLng currentLocation;
  LatLng destinationLocation;
  bool userBadgeSelected = false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();

    polylinePoints = PolylinePoints();

    // set up initial locations
    this.setInitialLocation();
    setPolylines();
  }

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    // String parentCat = widget.subCategory.imgName.split("_")[0];

    // driverIcon = await BitmapDescriptor.fromAssetImage(
    // ImageConfiguration(devicePixelRatio: 2.5), icona);
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), iconb);
    // checkicon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 2.5), iconb);

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), iconc);

    // sourceIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 2.0),
    //     'assets/imgs/source_pin${Utils.deviceSuffix(context)}.png');

    // destinationIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 2.0),
    //     'assets/imgs/destination_pin_${parentCat}${Utils.deviceSuffix(context)}.png');
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    // CategorySelectionService catSelection =
    //     Provider.of<CategorySelectionService>(context, listen: false);
    // widget.subCategory = catSelection.selectedSubCategory;

    this.setSourceAndDestinationMarkerIcons(context);

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            polylines: _polylines,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onTap: (LatLng loc) {
              setState(() {
                this.pinPillPosition = PIN_INVISIBLE_POSITION;
                this.userBadgeSelected = false;
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              showPinsOnMap();
              setPolylines();
            },
          ),
        ),
        // Positioned(
        //   top: 100,
        //   left: 0,
        //   right: 0,
        //   child: MapUserBadge(
        //     isSelected: this.userBadgeSelected,
        //   ),
        // ),
        // AnimatedPositioned(
        //     duration: const Duration(milliseconds: 500),
        //     curve: Curves.easeInOut,
        //     left: 0,
        //     right: 0,
        //     bottom: this.pinPillPosition,
        //     child: MapBottomPill()),
      ],
    ));
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentLocation,
          icon: sourceIcon,
          onTap: () {
            setState(() {
              this.userBadgeSelected = true;
            });
          }));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: destinationIcon,
          onTap: () {
            setState(() {
              this.pinPillPosition = PIN_VISIBLE_POSITION;
            });
          }));
    });
  }

  void setPolylines() async {
    var a = PointLatLng(19.2798547, 72.8740709);
    var b = PointLatLng(19.2798547, 72.8740709);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDfgqTqhA1NkD8KzwgIS6Z0nNwL2JV-cuQ",
      a,
      b,
    );

    // result.points.forEach((PointLatLng point) {
    //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    // });
    // setState(() {
    //   _polylines.add(Polyline(
    //       width: 10,
    //       polylineId: PolylineId('polyLine'),
    //       color: Color(0xFF08A5CB),
    //       points: polylineCoordinates));
    // });

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    } else {
      print('polyline ek number ka gochu hai');
    }
  }
}
