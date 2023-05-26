import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart'
as gmaps;
import 'package:vid_chex_app/Screens/map_screen/map_screen.dart';
import 'package:vid_chex_app/conts/Color.dart';


import '../../widgets/button.dart';
import '../../widgets/button_text.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

class ChatPage extends StatefulWidget {
  var userId;
  var houseid;
  var userImg;
  var firstName;
  var biderImg;
  var biderName;
  var proid;

  ChatPage({
    this.userId,
    this.houseid,
    this.userImg,
    this.firstName,

    this.biderName,
    this.proid, this.biderImg,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Handle case when user doesn't enable location services
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // Handle case when user doesn't grant location permission
        return null;
      }
    }

    return await location.getLocation();
  }

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  String otherUserUid = ""; // Initialize the other user's UID
  File? _image;
  Uuid uuid = Uuid();

  CameraPosition _initialPosition = CameraPosition(
    target: gmaps.LatLng(31.5204, 74.3587),
    zoom: 14.0,
  );
  void openMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    otherUserUid = widget.proid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0.0, 2.0), // horizontal, vertical offset
                  blurRadius: 6.0, // blur radius
                  spreadRadius: 0.0, // spread radius
                )
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                ListTile(
                  leading: Container(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.biderImg,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  title: TextWidget(
                    text: widget.biderName,
                    color: Colors.black,
                    textSize: 15,

                  ),
                  trailing: TextButton(
                    onPressed: () {
                      try {
                        FirebaseFirestore.instance
                            .collection("chatUser")
                            .doc(widget.proid)
                            .update({'Status': "Block"}).whenComplete(() {
                          Fluttertoast.showToast(msg: 'Block');
                          Navigator.pop(context);
                        });
                      } catch (error) {
                        Fluttertoast.showToast(msg: '$error');
                      }
                    },
                    child: TextWidget(
                      text: 'Block',
                      color: Color(0xffEB141B),
                      textSize: 14,

                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db
                  .collection('chats')
                  .doc(getChatRoomId(
                  FirebaseAuth.instance.currentUser!.uid, otherUserUid))
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!.docs.toList();
                return ListView.builder(

                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // double? lat;
                    // double? long;
                    final message = messages[index]['message'];
                    final sender = messages[index]['sender'];
                    final ChatImage = messages[index]['ChatImage'];
                    var lat  = messages[index]['latitude'];
                    var long = messages[index]['longitude'];
                    final Timestamp timestamp = messages[index]['timestamp'];
                    final DateTime time = timestamp.toDate(); // convert Timestamp to DateTime

                    String getDisplayTime() {
                      var difference = DateTime.now().difference(time);
                      if (difference.inSeconds < 60) {
                        return 'Just now';
                      } else if (difference.inMinutes < 60) {
                        return '${difference.inMinutes} minutes ago';
                      } else if (difference.inHours < 24) {
                        return '${difference.inHours} hours ago';
                      } else {
                        return '${difference.inDays} days ago';
                      }
                    }




                    return Column(
                      children: [

                        message == ""
                            ? SizedBox()
                            : sender == FirebaseAuth.instance.currentUser!.uid
                            ? ChatBubble(
                          clipper: ChatBubbleClipper1(
                              type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: CustomColors.green,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                              MediaQuery.of(context).size.width *
                                  0.7,
                            ),
                            child: Container(
                              width: 150,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        message,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 60,
                                      alignment: Alignment.centerRight,
                                      child:  Text(getDisplayTime(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                            : ChatBubble(
                          clipper: ChatBubbleClipper1(
                              type: BubbleType.receiverBubble),
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Color(0xffD7D7D7),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                              MediaQuery.of(context).size.width *
                                  0.7,
                            ),
                            child: Container(
                              width: 150,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        message,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 60,
                                      alignment: Alignment.centerRight,
                                      child:  Text(getDisplayTime(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 7,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ChatImage == ""
                              ? SizedBox()
                              : sender ==
                              FirebaseAuth
                                  .instance.currentUser!.uid &&
                              ChatImage == ChatImage
                              ? ChatBubble(
                            clipper: ChatBubbleClipper1(
                                type: BubbleType.sendBubble),
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 30),
                            backGroundColor: CustomColors.green,
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  // height: 120,
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        ChatImage,
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(getDisplayTime(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              : ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 30),
                              backGroundColor: Color(0xffD7D7D7),
                              child: Container(
                                width: 100,
                                // height: 100,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Image.network(
                                      ChatImage,
                                    ),
                                    SizedBox(height: 5,),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(getDisplayTime(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),



                        Container(
                          child:
                          lat == "" && long == ""
                              ? SizedBox()
                              : sender == FirebaseAuth.instance.currentUser!.uid
                              ? ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 30),
                              backGroundColor: CustomColors.green,
                              child: GestureDetector(
                                onTap: () {

                                  var destinationLatitude = lat;
                                  var destinationLongitude = long;
                                  openMaps(destinationLatitude, destinationLongitude);

                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 140,
                                      width: 125,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 125,
                                            width: 125,
                                            child: IgnorePointer(
                                              child: lat != "" && long != "" // only show the map if both lat and long are not null
                                                  ? gmaps.GoogleMap(
                                                initialCameraPosition: gmaps.CameraPosition(
                                                  target: gmaps.LatLng(lat, long), // replace with your latitude and longitude values
                                                  zoom: 12.0,
                                                ),
                                                mapType: gmaps.MapType.normal,
                                              ) : null,
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            height: 10,
                                            width: 125,
                                            child:  Text(getDisplayTime(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      width: 125,
                                      color: Colors.transparent,
                                    ),
                                  ],
                                ),
                              )

                          )
                              :
                          ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 30),
                              backGroundColor: Color(0xffD7D7D7),
                              child: GestureDetector(
                                onTap: () {
                                  var destinationLatitude = lat;
                                  var destinationLongitude = long;
                                  openMaps(destinationLatitude, destinationLongitude);
                                },
                                child: Stack(
                                  children: [

                                    Container(
                                      height: 140,
                                      width: 125,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 125,
                                            width: 125,
                                            child: lat != "" && long != "" // only show the map if both lat and long are not null
                                                ? gmaps.GoogleMap(
                                              initialCameraPosition: gmaps.CameraPosition(
                                                target: gmaps.LatLng(lat,long), // replace with your latitude and longitude values
                                                zoom: 12.0,
                                              ),
                                              mapType: gmaps.MapType.normal,
                                            ) : null,
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            height: 10,
                                            width: 125,
                                            child:  Text(getDisplayTime(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      width: 125,
                                      color: Colors.transparent,
                                    ),

                                  ],
                                ),
                              )
                          ),


                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 2,),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                          width: 240,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff000000).withOpacity(0.08),
                          ),
                          child: TextFormField(
                            controller: _textEditingController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: PopupMenuButton<int>(
                                icon: Icon(Icons.file_present_outlined),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final picker = ImagePicker();
                                              await picker
                                              // ignore: deprecated_member_use
                                                  .getImage(
                                                  source: ImageSource.camera)
                                                  .then((value) {
                                                _image = File(value!.path);
                                                Reference reference =
                                                FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child('chats')
                                                    .child(
                                                    uuid.v4().toString());
                                                UploadTask task =
                                                reference.putFile(_image!);
                                                task.whenComplete(() {
                                                  reference
                                                      .getDownloadURL()
                                                      .then((imgurl) async {
                                                    await _db
                                                        .collection('chats')
                                                        .doc(getChatRoomId(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        otherUserUid))
                                                        .collection('messages')
                                                        .add({
                                                      'uid': FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      'message': "",
                                                      'sender': FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid,
                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                      'ChatImage': imgurl
                                                    }).then((value) {
                                                      Fluttertoast.showToast(
                                                          msg: 'Image add');
                                                    }).onError((error, stackTrace) {
                                                      Fluttertoast.showToast(
                                                          msg: '$error');
                                                    });
                                                  });
                                                });
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Icons.camera_alt_outlined),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                TextWidget(
                                                    text: 'Camera',
                                                    color: Color(0xff878787),
                                                    textSize: 10,
                                                    )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final picker = ImagePicker();
                                              await picker
                                              // ignore: deprecated_member_use
                                                  .getImage(
                                                  source: ImageSource.gallery)
                                                  .then((value) {
                                                _image = File(value!.path);
                                                Reference reference =
                                                FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child('chats')
                                                    .child(
                                                    uuid.v4().toString());
                                                UploadTask task =
                                                reference.putFile(_image!);
                                                task.whenComplete(() {
                                                  reference
                                                      .getDownloadURL()
                                                      .then((imgurl) async {
                                                    await _db
                                                        .collection('chats')
                                                        .doc(getChatRoomId(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        otherUserUid))
                                                        .collection('messages')
                                                        .add({
                                                      'uid': FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      'message': "",
                                                      'latitude': "",
                                                      'longitude': "",
                                                      'sender': FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid,
                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                      'ChatImage': imgurl,
                                                      'Read'      : false,
                                                    }).then((value) {
                                                      Fluttertoast.showToast(
                                                          msg: 'Image add');
                                                    }).onError((error, stackTrace) {
                                                      Fluttertoast.showToast(
                                                          msg: '$error');
                                                    });
                                                  });
                                                });
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(CupertinoIcons.photo),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                TextWidget(
                                                    text: 'Gallery',
                                                    color: Color(0xff878787),
                                                    textSize: 10,
                                                    )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _openMapAndSelectLocation(context);
                                            },
                                            child: Column(
                                              children: [
                                                Icon(Icons.location_on),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                TextWidget(
                                                    text: 'Location',
                                                    color: Color(0xff878787),
                                                    textSize: 10,
                                                    )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              border: InputBorder.none,
                              hintText: 'Write your message here....',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              hintStyle: TextStyle(
                                color: Color(0xff6B6B6B),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ))),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_textEditingController.text.trim().isNotEmpty) {
                        final message = _textEditingController.text.trim();
                        _textEditingController.clear();
                        await _db
                            .collection('chats')
                            .doc(getChatRoomId(
                            FirebaseAuth.instance.currentUser!.uid, otherUserUid))
                            .collection('messages')
                            .add({
                          'uid': FirebaseAuth.instance.currentUser!.uid,
                          'message': message,
                          'sender': FirebaseAuth.instance.currentUser!.uid,
                          'timestamp': FieldValue.serverTimestamp(),
                          'ChatImage': "",
                          'latitude': "",
                          'longitude': "",
                          'Read': false,
                        });
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.green,
                    ),
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openMapAndSelectLocation(BuildContext context) async {
    final gmaps.LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Around_Me_1(
            OtherId: otherUserUid
        ),
      ),
    );
  }
}