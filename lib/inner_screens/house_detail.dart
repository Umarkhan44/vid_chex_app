import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/inner_screens/agent_profile.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';
import 'package:video_player/video_player.dart';

class HouseDetail extends StatefulWidget {
  final String bathroom;
  final String category;
  final String description;
  final String garage;
  final String kitchen;
  final String room;
  final String type;
  final String price;
  final String location;
  var videoUrl;
  final String firstName;
  var userImg;
  var about;
  var proid;
  var houseid;
  // var timestamp;
  // var Status;
  // var AcceptedTime;

  HouseDetail({
    Key? key,
    required this.bathroom,
    required this.category,
    required this.description,
    required this.garage,
    required this.kitchen,
    required this.room,
    required this.type,
    required this.price,
    required this.location,
    required this.videoUrl,
    required this.firstName,
    required this.userImg,
    required this.about,
    required this.houseid,
    required this.proid,
    // required this.Status,
    // required this.timestamp,
    // required this.AcceptedTime,
  }) : super(key: key);

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {
  final user = FirebaseAuth.instance.currentUser;

  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, right: 1, left: 1),
                height: height * 0.38,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.black87,
                ),
                child: Stack(
                  children: [
                    FutureBuilder(
                      future: VideoPlayerController.network(widget.videoUrl)
                          .initialize(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Chewie(
                            controller: _chewieController,
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    Positioned(
                      top: height * 0.02,
                      left: width * 0.045,
                      child: Container(
                        color: Colors.white.withOpacity(0.2),
                        height: height * 0.035,
                        width: width * 0.085,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: height * 0.017,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.only(
                    top: height * 0.012,
                    left: width * 0.045,
                    right: width * 0.045),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                      left: width * 0.008,
                      bottom: height * 0.01,
                      right: width * 0.008),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "Highest Bid     ",
                        color: Colors.black,
                        textSize: height * 0.025,
                        isTitle: true,
                      ),
                      SizedBox(
                        height: height * 0.012,
                      ),
                      Text(
                        'By James Rofsan',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: height * 0.000018,
                        ),
                      ),
                    ],
                  ),
                  trailing: TextWidget(
                    text: "\$ 178,000",
                    color: CustomColors.green,
                    textSize: height * 0.025,
                    isTitle: true,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Container(
                height: height * 0.240,
                width: width * 0.924,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height * 0.02),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: widget.type,
                            color: CustomColors.black,
                            textSize: 18,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: '\$ ${widget.price}',
                            color: CustomColors.green,
                            textSize: 17,
                            isTitle: true,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 29,
                                width: 29,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff099E80).withOpacity(
                                        0.6) // or any other color you want
                                    ),
                                child: Image.asset(
                                  'assets/bed 1.png',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.kitchen,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 29,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 29,
                                width: 29,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff099E80).withOpacity(
                                        0.6) // or any other color you want
                                    ),
                                child: Image.asset(
                                  'assets/bathtub 1.png',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.bathroom,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 29,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 29,
                                width: 29,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff099E80).withOpacity(
                                        0.6) // or any other color you want
                                    ),
                                child: Image.asset(
                                  'assets/kitchen-set 1.png',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.room,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextWidget(
                        text: "Description",
                        color: Color(0xff484848),
                        textSize: 14,
                        isTitle: true,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextWidget(
                        text: widget.description,
                        color: Color(0xff484848),
                        textSize: 10,
                        isTitle: true,
                        maxLine: 7,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AgentProfile(
                        firstName: widget.firstName,
                        userImg: widget.userImg,
                        about: widget.about,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.only(top: 12, left: 15, right: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  color: Colors.white,
                  child: ListTile(
                      leading: Image.network(
                        widget.userImg,
                        height: 51,
                        width: 51,
                        fit: BoxFit.cover,
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 8, bottom: 1, right: 8),
                      title: TextWidget(
                        text: widget.firstName,
                        color: Colors.black,
                        textSize: 16,
                        isTitle: true,
                      ),
                      subtitle: Text('View Agent Profile',
                          style: TextStyle(color: Colors.grey)),
                      trailing: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => AgentProfile(
                                    userImg: 'userImg',
                                    firstName: 'firstName',
                                    about: 'about'),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: CustomColors.green,
                            size: 19,
                          ))),
                ),
              ),
              SizedBox(
                height: 41,
              ),
              ElevatedButton(
                onPressed: () {
                  _showAlertDialog(
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff099E80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // 20 is the radius of the circular shape
                  ),
                  minimumSize: Size(150, 43), // set the width and height
                ),
                child: Text('Bid'),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  final _bitcontroller = TextEditingController();
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your bid',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                TextFormField(
                  controller: _bitcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter \$0",
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                ),
                SizedBox(
                  height: 44,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context); // Close the dialog
                    await saveBidToFirebase();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff099E80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: Size(200, 43),
                  ),
                  child: Text('Bid'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  // Future<void> saveBidToFirebase() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   final String? userId = user?.uid;
  //   final String? userName = user?.displayName; // Get the user's name
  //   final usersRef = FirebaseFirestore.instance.collection('users');
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   final userDoc = await usersRef.doc().get();
  //
  //   if (userId != null) {
  //     // Check if the user has already placed a bid on this house
  //     final QuerySnapshot<Map<String, dynamic>> existingBids =
  //     await FirebaseFirestore.instance
  //         .collection('bids')
  //         .where('userId', isEqualTo: userId)
  //         .where('houseid', isEqualTo: widget.houseid)
  //         .get();
  //
  //     if (existingBids.docs.isNotEmpty) {
  //       // If the user has already placed a bid on this house, show an error message
  //       await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('You have already placed a bid on this house.'),
  //       ));
  //     } else {
  //       // Save the bid to Firebase
  //       final uuid = Uuid().v1();
  //       final DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection('bids').doc(uuid);
  //       await documentReference.set({
  //         'uuid': uuid,
  //         'userId': userId,
  //         'bidAmount': _bitcontroller.text.toString(),
  //         'timestamp': DateTime.now().toUtc(),
  //         'bathroom': widget.bathroom,
  //         'category': widget.category,
  //         'descripti': widget.description,
  //         'garage': widget.garage,
  //         'kitchen': widget.kitchen,
  //         'room': widget.room,
  //         'type': widget.type,
  //         'price': widget.price,
  //         'location': widget.location,
  //         'videoUrl': widget.videoUrl,
  //         'firstName': widget.firstName,
  //
  //         'userImg': widget.userImg,
  //         'about': widget.about,
  //         'houseid': widget.houseid,
  //         'proid': widget.proid,
  //         'Status': 'Pending',
  //         'AcceptedTime': DateTime.now(),
  //         'paymentStatus': 'Pending',
  //         'paymentDate': DateTime.now(),
  //         'username': userName, // Add the user's name to the bid document
  //       });
  //
  //       // Show a success message
  //       await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Your bid has been sent.'),
  //       ));
  //     }
  //   } else {
  //     // Show an error message if the user is not logged in
  //     await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('You need to log in to place a bid.'),
  //     ));
  //   }
  // }

  Future<void> saveBidToFirebase() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    final usersRef = FirebaseFirestore.instance.collection('user');
    final currentUser = FirebaseAuth.instance.currentUser;
    final userDoc = await usersRef.doc(currentUser?.uid).get();

    if (userDoc.exists) {
      final firstName = userDoc.data()?['firstName'];
      final biderImg = userDoc.data()?['userImg'];
      final biderid = userDoc.data()?['userid'];

      // Check if the user has already placed a bid on this house
      final QuerySnapshot<Map<String, dynamic>> existingBids =
      await FirebaseFirestore.instance
          .collection('bids')
          .where('userId', isEqualTo: userId)
          .where('houseid', isEqualTo: widget.houseid)
          .get();

      if (existingBids.docs.isNotEmpty) {
        // If the user has already placed a bid on this house, show an error message
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You have already placed a bid on this house.'),
        ));
      } else {
        // Save the bid to Firebase
        final uuid = Uuid().v1();
        final DocumentReference documentReference =
        FirebaseFirestore.instance.collection('bids').doc(uuid);
        await documentReference.set({
          'uuid': uuid,
          'userId': userId,
          'bidAmount': _bitcontroller.text.toString(),
          'timestamp': DateTime.now().toUtc(),
          'bathroom': widget.bathroom,
          'category': widget.category,
          'descripti': widget.description,
          'garage': widget.garage,
          'kitchen': widget.kitchen,
          'room': widget.room,
          'type': widget.type,
          'price': widget.price,
          'location': widget.location,
          'videoUrl': widget.videoUrl,
          'firstName': widget.firstName,
          'userImg': widget.userImg,
          'about': widget.about,
          'houseid': widget.houseid,
          'proid': widget.proid,
          'Status': 'Pending',
          'RequestTime': DateTime.now(),
          'paymentStatus': 'Pending',
          'paymentDate': DateTime.now(),
          'biderName': firstName ?? '',
          'biderImg': biderImg ?? '',
          'biderid': biderid ?? '',
        });

        // Show a success message
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your bid has been sent.'),
        ));
      }
    } else {
      // Show an error message if the user is not logged in
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You need to log in to place a bid.'),
      ));
    }
  }


  Future<void> updateBidInFirebase(String uuid, DateTime acceptedTime) async {
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection('bids').doc(uuid);
    await documentReference.update({
      'AcceptedTime': acceptedTime.toUtc(),
    });
  }




}
