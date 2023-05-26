import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_bid_details.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_bid_widget.dart';
import 'package:vid_chex_app/inner_screens/house_detail.dart';
import 'package:vid_chex_app/widgets/house_list.dart';

class MyBidings extends StatelessWidget {
  MyBidings({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
   String acceptedTime ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bids')
                  .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (ctx, index) {
                      final house = snapshot.data!.docs[index];
                      // Convert AcceptedTime timestamp to DateTime and format it
                      DateTime? requestedTime = (house['RequestTime'] as Timestamp?)?.toDate();
                      String formattedAcceptedTime = requestedTime != null
                          ? DateFormat('dd MMM, hh:mm a').format(requestedTime)
                          : '';
                     if( house['Status'] == "Pending"){


                     }else if ( house['Status'] == "Accepted"){
                       DateTime? requestedTime = (house['ApproveTie'] as Timestamp?)?.toDate();
                        acceptedTime = requestedTime != null
                           ? DateFormat('dd MMM, hh:mm a').format(requestedTime)
                           : '';
                     }


                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {

                            print(house["paymentStatus"]);
                           // print(formattedAcceptedTime);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => MyBidDetails(
                                  bathroom: house['bathroom'],
                                  category: house['category'],
                                  descripti: house['descripti'],
                                  garage: house['garage'],
                                  kitchen: house['kitchen'],
                                  room: house['room'],
                                  type: house['type'],
                                  price: house['price'],
                                  firstName: house['firstName'],
                                  userImg: house['userImg'],
                                  about: house['about'],
                                  bidAmount: house['bidAmount'],
                                  Status: house['Status'],
                                  RequestTime: formattedAcceptedTime,
                                  ApproveTime: acceptedTime,
                                  payentDate: house['paymentDate'],
                                  uuid: house['uuid'],
                                  houseid: house["houseid"],
                                  userId: house["userId"],
                                  paymentStatus: house["paymentStatus"],
                                  proid: house["proid"],
                                  biderImg: house["biderImg"],
                                  biderName: house["biderName"],



                                ),
                              ),
                            );
                          },
                          child: MyBidWidget(
                            bathroom: house['bathroom'],
                            bidAmount: house['bidAmount'],
                            category: house['category'],
                            // descripti: house['descripti'],
                            // garage: house['garage'],
                            // kitchen: house['kitchen'],
                            // room: house['room'],
                            // type: house['type'],
                            price: house['price'],
                            location: house['location'],
                            // videoUrl: house['videoUrl'],
                            // firstName: house['firstName'],
                            // userImg: house['userImg'],
                            // houseid: house["houseid"],
                            // proid: house["providedBy"],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator(); // You can replace this with any loading widget of your choice
                }
              },
            )

          ],
        ),
      ),
    );
  }
}