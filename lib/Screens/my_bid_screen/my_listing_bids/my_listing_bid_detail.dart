import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_listing_bids/my_listing_progressline.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/button_text.dart';

class MyLisstingBidDetail extends StatefulWidget {
  var bathroom;
  var location;
  var garage;
  var category;
  var kitchen;
  var room;
  var type;
  var videoUrl;
  var description;
  var price;
  var houseid;
  var userId;

  MyLisstingBidDetail({Key? key,
     required this.bathroom,
     required this.category,
     required this.description,
     required this.garage,
     required this.kitchen,
     required this.room,
     required this.type,
     required this.location,
     required this.videoUrl,
     required this.price,
     required this.houseid,
   }) : super(key: key);

  @override
  State<MyLisstingBidDetail> createState() => _MyLisstingBidDetailState();
}

class _MyLisstingBidDetailState extends State<MyLisstingBidDetail> {


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

    // Get the current user's ID
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Create a stream that listens for changes in the user document with the current user's ID
      final Stream<DocumentSnapshot<Map<String, dynamic>>> userStream =
      FirebaseFirestore.instance.collection('user').doc(userId).snapshots();

      // Use the user data in the stream to update the UI
      // For example, you could use a StreamBuilder widget to display the user's name and profile picture
      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          if (!snapshot.hasData) {
            return Text('No data');
          }

          final data = snapshot.data?.data();
          final String? userName = data?['firstName'];

          return Text('Welcome, $userName');
        },
      );
    }
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

    return Scaffold(
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
                    future: VideoPlayerController.network(widget.videoUrl).initialize(),
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
                    right: width * 0.045,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                        Container(
                          height: height * 0.035,
                          width: width * 0.085,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: height * 0.017,
                              color: Colors.red,
                            ),
                            onPressed: () {

                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
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
                    color:
                    Colors.black.withOpacity(0.2),
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: widget.type,
                            color: CustomColors.black,
                            textSize: 18,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: widget.price,
                            color: CustomColors.green,
                            textSize: 17,
                            isTitle: true,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                widget.room,
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
                          Flexible(
                            child: Row(
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
                                  widget.kitchen,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                    Expanded(
                      flex: 4,
                      child: TextWidget(
                        text:
                       widget.description,
                        color: Color(0xff484848),
                        textSize: 10,
                        isTitle: true,
                        maxLine: 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

      SizedBox(height: 15,),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("bids")


                .where('houseid', isEqualTo: widget.houseid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var bidDocs = snapshot.data!.docs;
                return ListView.builder(
                  padding: EdgeInsets.only(left: 1),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: bidDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot bid = bidDocs[index];

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              text: "Bids",
                              color: CustomColors.black,
                              textSize: 18,
                              isTitle: true,
                            ),
                          ),
                        ),
                         ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "By ${bid["biderName"]}",
                                color: CustomColors.black,
                                textSize: 14,
                                isTitle: true,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextWidget(
                                text: "\$ ${bid["bidAmount"]}",
                                color: CustomColors.green,
                                textSize: 14,
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              try {
                                FirebaseFirestore.instance
                                    .collection('bids')
                                    .doc(snapshot.data?.docs[index]['uuid'])
                                    .update({
                                  'Status': 'Accepted',
                                  'ApproveTie': DateTime.now(),
                                   // Add the accepted time field
                                }).then((value) {
                                  _showAlertDialog(context);

                                  // Wait for 3 seconds
                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => MyListingProgress(


                                        ), // Replace MyNextScreen with the actual screen you want to navigate to
                                      ),
                                    );
                                  });
                                }).whenComplete(() {
                                  // Remove other bids with 'Pending' status
                                  FirebaseFirestore.instance
                                      .collection('bids')
                                      .where('Status', isEqualTo: 'Pending')
                                      .where('houseid', isEqualTo: widget.houseid)
                                      .get()
                                      .then((querySnapshot) {
                                    querySnapshot.docs.forEach((doc) {
                                      doc.reference.delete();
                                    });
                                  });

                                  // // Update status of remaining bids to 'Not Accepted'
                                  // FirebaseFirestore.instance
                                  //     .collection('bids')
                                  //     .where('Status', isEqualTo: 'Pending')
                                  //     .where('houseid', isEqualTo: widget.houseid)
                                  //     .get()
                                  //     .then((querySnapshot) {
                                  //   querySnapshot.docs.forEach((doc) {
                                  //     doc.reference.update({'Status': 'Pending'});
                                  //   });
                                  // });
                                });
                              } catch (error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(error.toString())));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff099E80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  9.0, // 20 is the radius of the circular shape
                                ),
                              ),
                              minimumSize: Size(70, 33), // set the width and height
                            ),
                            child: TextWidget(
                              text: "Accepts",
                              color: Colors.white,
                              textSize: 18,
                              isTitle: true,
                            ),
                          ),



                        ),
                      ],
                    );
                  },
                );
              },
            ),

      ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) async {
    // Update the bid status in Firebase

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/accept.png"),
                SizedBox(height: 24,),
                TextWidget(
                  text: "Bid Accepted!",
                  color: CustomColors.green,
                  textSize: 23,
                  isTitle: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
