import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_listing_bids/my_listing_bid_detail.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button_text.dart';
import 'my_listing_progressline.dart';

class MyListings extends StatefulWidget {
  const MyListings({Key? key}) : super(key: key);

  @override
  State<MyListings> createState() => _MyListingsState();
}

class _MyListingsState extends State<MyListings> {
  String? _thumbnailUrl;

  @override
  void initState() {
    super.initState();

    generateThumbnail();
  }

  void generateThumbnail() async {
    try {
      await FirebaseFirestore.instance
          .collection("house")
          .snapshots()
          .listen((snapshot) {
        snapshot.docs.forEach((doc) {
          setState(() {
            _thumbnailUrl = doc.data()['videoUrl'];
          });
        });
      });
    } catch (e) {
      print('Error getting image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ...
    // use `data` to render your widget

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('house')
                .where('providedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, houseSnapshot) {
              if (!houseSnapshot.hasData || houseSnapshot.data!.docs.isEmpty) {
                return Center(child: Text("NO houses posted yet"));
              }

              List<String> houseIds = houseSnapshot.data!.docs.map((doc) => doc.id).toList();

              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bids')
                      .where('houseid', whereIn: houseIds).where('proid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, bidSnapshot) {
                    if (!bidSnapshot.hasData || bidSnapshot.data!.docs.isEmpty) {
                      return Center(child: Text("NO bids yet"));
                    }

                    List bidHouseIds = bidSnapshot.data!.docs.map((doc) => doc['houseid']).toList();

                    List<DocumentSnapshot> houses = houseSnapshot.data!.docs.where((doc) => bidHouseIds.contains(doc.id)).toList();

                    return ListView.builder(
                        itemCount: houses.length,
                        itemBuilder: (context, index) {
                          final house = bidSnapshot.data!.docs[index];
                          String status = house['Status'];
                          return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12, left: 12, right: 12),
                              child: InkWell(
                                  onTap: () {
                                    // // Convert timestamp to DateTime and format it
                                    // DateTime timestamp =
                                    //     (house['timestamp'] as Timestamp)
                                    //         .toDate();
                                    // String formattedTime =
                                    //     DateFormat('dd MMM, hh:mm a')
                                    //         .format(timestamp);
                                    //
                                    // Convert AcceptedTime timestamp to DateTime and format it
                                    // DateTime? acceptedTime =
                                    //     (house['ApproveTie'] as Timestamp?)
                                    //         ?.toDate();
                                    // String formattedAcceptedTime =
                                    //     acceptedTime != null
                                    //         ? DateFormat('dd MMM, hh:mm a')
                                    //             .format(acceptedTime)
                                    //         : '';


                                     if (status == 'Pending')
                                    {
                                      Navigator.push(

                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyLisstingBidDetail(
                                            bathroom: house['bathroom'],
                                            category: house['category'],


                                            description: house['descripti'],
                                            garage: house['garage'],
                                            kitchen: house['kitchen'],
                                            room: house['room'],
                                            type: house['type'],
                                            price: house['price'],
                                            location: house['location'],
                                            videoUrl: house['videoUrl'],
                                            houseid: house['houseid'],
                                          ),
                                        ),
                                      );
                                     }

                                      else


                                        Navigator.push(

                                          context,

                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MyListingProgress(
                                                  text:"Seller",
                                                  bathroom: house['bathroom'],
                                                  category: house['category'],
                                                  Status:house['Status'] ,
                                                  description: house['descripti'],
                                                  garage: house['garage'],
                                                  kitchen: house['kitchen'],
                                                  room: house['room'],
                                                  type: house['type'],
                                                  price: house['price'],
                                                  location: house['location'],
                                                  videoUrl: house['videoUrl'],
                                                  houseid: house['houseid'],
                                                  firstName:house['firstName'],
                                                  bidAmount:house['bidAmount'],
                                                  userImg:house['userImg'],
                                                  biderName:house['biderName'],
                                                  biderImg:house['biderImg'],
                                                  userId:house['userId'],
                                                  biderid:house['biderid'],
                                                  proid:house['proid'],
                                                  //ApproveTime: formattedAcceptedTime,
                                                ),
                                          ),
                                        );

                                      print(house['videoUrl']);
                                      print(house['garage']);
                                      print(house['proid']);
                                  },
                                  child: Material(
                                    elevation: 1,
                                    child: Container(
                                      height: 112,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          bottom: 7,
                                          top: 8,
                                        ),
                                        leading: Container(
                                          width: 70.0,
                                          height: 56.0,
                                          child: _thumbnailUrl != null
                                              ? Image.network(
                                                  _thumbnailUrl!,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    // Error widget to show when image fails to load
                                                    return Container(
                                                      color: Colors.red,
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  color: Colors.red,
                                                ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 5,
                                                  child: TextWidget(
                                                    text: house['category'],
                                                    textSize: 16,
                                                    color: Colors.black,
                                                    isTitle: true,
                                                    maxLine: 1,
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 9,
                                                  child: TextWidget(
                                                    text:
                                                        '\$ ${house['price']}',
                                                    textSize: 16,
                                                    color: CustomColors.green,
                                                    isTitle: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            TextWidget(
                                              text: house['location'],
                                              textSize: 10,
                                              color: Color(0xff828282),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Highest Bid:',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: ' \$ 139,000 ',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xffFF9B42),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )));
                        });
                  });
            }));
  }
}

// StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance
//         .collection('houses')
//         .where('providedBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .snapshots(),
//     builder: (context, houseSnapshot) {
//       if (!houseSnapshot.hasData) {
//         return Center(child: CircularProgressIndicator());
//       }
//
//       List<String> houseIds =
//       houseSnapshot.data!.docs.map((doc) => doc.id).toList();
//
//       return StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('bids')
//               .where('userId',
//               isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//               .snapshots(),
//           builder: (context, bidSnapshot) {
//             if (!bidSnapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             List bidHouseIds = bidSnapshot.data!.docs
//                 .map((doc) => doc['houseid'])
//                 .toSet()
//                 .toList();
//             List bidStatuses = bidSnapshot.data!.docs
//                 .map((doc) => doc['status'])
//                 .toSet()
//                 .toList();
//
//             List<DocumentSnapshot> houses = [];
//             houseSnapshot.data!.docs.forEach((doc) {
//               if (houseIds.contains(doc.id) || bidHouseIds.contains(doc.id)) {
//                 houses.add(doc);
//               }
//             });
//
//             return ListView.builder(
//                 itemCount: houses.length,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot house = houses[index];
//                   String bidStatus = bidStatuses[                    bidHouseIds.indexOf(house.id)                ] ?? '';
//

//           });
//     })
