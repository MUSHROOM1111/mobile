import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rookkie_app_v2/pages/restaurant_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  double lat;
  double lng;

  double currentLat = 14.021302231438153;
  double currentLng = 99.99155580997467;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static final CameraPosition myPosition = CameraPosition(
    target: LatLng(14.02075803951151, 99.99225774736021),
    zoom: 16,
  );

  Future gotoCurrentPosition() async {
    CameraPosition currentPosition = CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(lat, lng),
        // tilt: 59.440717697143555,
        zoom: 16);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
  }

  Future getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    print("position");
    print(position);
    print("geolocationStatus");
    print(geolocationStatus);
    setState(() {
      lat = position.latitude ?? 14.021302231438153;
      lng = position.longitude ?? 99.99155580997467;
      // lat = 14.0145444;
      // lng = 99.9923058;
    });
  }

  void _add() {
    final MarkerId markerId = MarkerId('1');

    setState(() {
      if (markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });

    final Marker marker = Marker(
      markerId: markerId,
      icon: _markerIcon,
      position: LatLng(currentLat, currentLng),
      infoWindow: InfoWindow(title: 'ตำแหน่งปัจจุบัน', snippet: '*'),
      onTap: () {},
      // onDragEnd: (LatLng position) {
      //   _onMarkerDragEnd(markerId, position);
      // },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    // _add();
  }

  double _height;
  double _width;

  BitmapDescriptor _markerIcon;

  Future _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      ImageConfiguration configuration = ImageConfiguration();
      BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
          configuration, 'assets/icons/mark_1.png');
      setState(() {
        _markerIcon = bmpd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('ไปส่งที่'),
        // actions: <Widget>[
        //   RaisedButton(
        //     // color: Colors.orange,
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   RestaurantPage(this.lat, this.lng)));
        //       print('Routing to Electronics item list');
        //     },
        //     child: Text('เลือกร้านอาหาร',
        //         style: TextStyle(fontSize: 20.0, color: Colors.black)),
        //   )
        // ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: myPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(markers.values),
            onCameraMove: (CameraPosition position) {
              print("position in mar_page = $position");
              // print(position.target.latitude);
              // print(_height);
              setState(() {
                currentLat = position.target.latitude;
                currentLng = position.target.longitude;
              });

              _add();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: IconButton(
                      icon: Icon(
                        Icons.location_searching,
                        color: Colors.black,
                        // size: 50,
                      ),
                      onPressed: () {
                        gotoCurrentPosition();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Center(
          //     // heightFactor: _height - 550,
          //     child: Image.asset(
          //   'assets/icons/mark_3.png',
          //   width: 30,
          // )),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: MaterialButton(
          child: Text(
            "ยืนยัน ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RestaurantPage(this.currentLat, this.currentLng)));
            print('Routing to Restaurants list');
          },
          elevation: 4.0,
          minWidth: double.infinity,
          height: 48.0,
          color: Colors.orange,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: RaisedButton(
      //   color: Colors.orange,
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => RestaurantPage(this.lat, this.lng)));
      //     print('Routing to Electronics item list');
      //   },
      //   child: Text('ยืนยันตำแหน่งจัดส่ง',
      //       style: TextStyle(fontSize: 20.0, color: Colors.black)),
      // ),
      // body: Container(
      //   height: _height,
      //   child: Stack(
      //     children: <Widget>[
      //       GoogleMap(
      //         mapType: MapType.normal,
      //         initialCameraPosition: myPosition,
      //         onMapCreated: (GoogleMapController controller) {
      //           _controller.complete(controller);
      //         },
      //         markers: Set<Marker>.of(markers.values),
      //         onCameraMove: (CameraPosition position) {
      //           print(position);
      //           setState(() {
      //             currentLat = position.target.latitude;
      //             currentLng = position.target.longitude;
      //           });

      //           _add();
      //         },
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(20.0),
      //         child: Align(
      //           alignment: Alignment.topRight,
      //           child: Column(
      //             children: <Widget>[
      //               FloatingActionButton(
      //                 onPressed: () {
      //                   gotoCurrentPosition();
      //                   _add();
      //                 },
      //                 child: Icon(Icons.home),
      //               ),
      //               SizedBox(
      //                 height: 10.0,
      //               ),
      //               FloatingActionButton(
      //                 onPressed: () {},
      //                 child: Icon(Icons.location_searching),
      //               ),
      //               SizedBox(
      //                 height: 10.0,
      //               ),
      //               FloatingActionButton(
      //                 onPressed: () {},
      //                 child: Icon(Icons.map),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }
}
