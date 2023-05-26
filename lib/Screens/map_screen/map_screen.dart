import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/botton_nevg.dart';
import 'package:vid_chex_app/Screens/chat/chat_page.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../chat/check.dart';

class Around_Me_1 extends StatefulWidget {
  var OtherId;
   Around_Me_1({Key? key, this.OtherId}) : super(key: key);

  @override
  State<Around_Me_1> createState() => _Around_Me_1State();
}

class _Around_Me_1State extends State<Around_Me_1> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex; // Make it nullable

  final Location location = Location();
  LocationData? _currentPosition;
  Marker? _currentLocationMarker;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final currentLocation = await location.getLocation();
    setState(() async {
      _currentPosition = currentLocation;
      _currentLocationMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(
          _currentPosition!.latitude!,
          _currentPosition!.longitude!,
        ),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet:
          'Lat: ${_currentPosition!.latitude}, Lng: ${_currentPosition!.longitude}',
        ),
      );

      markers.add(_currentLocationMarker!);

      _kGooglePlex = CameraPosition(
        target: LatLng(
          _currentPosition!.latitude!,
          _currentPosition!.longitude!,
        ),
        zoom: 14.4746,
      );

      if (_kGooglePlex != null && _controller.isCompleted) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex ?? CameraPosition(
                target: LatLng(0, 0), // Default target if _kGooglePlex is null
                zoom: 14.4746,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: markers, // Add the markers to the GoogleMap widget
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            // In the onMapCreated callback,
            // after completing the controller, the code checks if
            // _currentLocationMarker is not null. If it exists, the camera is animated to the marker's position using controller.animateCamera. This will move the camera to your current location marker position when the map is created.

            Positioned(
              top: 10,
              right: 10,
              left: 19,
              child: Column(
                children: [
                  ListTile(
                    leading: CustomBackButton(
                      size: Size(33, 33),
                      color: Colors.black,
                    ),
                    title: TextWidget(
                      textSize: 18,
                      color: Colors.black,
                      text: "Location",
                      isTitle: true,
                    ),
                    horizontalTitleGap: 87,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 9,
                                spreadRadius: 8,
                                color: Colors.grey.withOpacity(0.15),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.95),
                              hintText: "Search location here...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: CustomColors.green,
                            borderRadius: BorderRadius.circular(17)),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: 88,
              right: 85,
              child:AuthButton(
                primary: CustomColors.green,
                fuc: ()  {
                   _saveLocation(widget.OtherId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChatPage(),
                    ),
                  );
                },
                textWidget: TextWidget(
                  text: "Save",
                  color: Colors.white,
                  textSize: 18,
                ),
              ),


            ),
          ],
        ),
      ),
    );
  }

  void _saveLocation(String chatRoomId) async {
    // Get the current user's ID
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Get the current location
    LocationData locationData;
    var location = Location();

    try {
      locationData = await location.getLocation();
    } catch (e) {
      // Handle location error
      print('Error getting location: $e');
      return;
    }

    // Extract latitude and longitude from location data
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    // Create a location document with user ID, latitude, and longitude
    final locationDocument = {
      'uid': userId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': FieldValue.serverTimestamp(),
      'isImage': false, // Assuming it's not an image message
    };

    try {
      // Save the location document to Firestore
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(chatRoomId)
          .collection('chats')
          .add(locationDocument);

      print('Location saved successfully!');
    } catch (e) {
      // Handle Firestore error
      print('Error saving location: $e');
    }
  }



}
