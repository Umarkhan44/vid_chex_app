import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:vid_chex_app/Screens/chat/chat_page.dart';
import 'package:vid_chex_app/Screens/chat/chat_screen.dart';

import '../../../conts/Color.dart';
import '../../../inner_screens/agent_profile.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/button_text.dart';
import '../../chat/check.dart';
import '../../payements/payments_selections.dart';
import '../progress_line.dart';

class MyListingProgress extends StatefulWidget {
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
  var firstName;
  var Status;
  var bidAmount;
  var ApproveTime;
  var userId;
  var shouseid;
  var sellerId;
  var text;
  var userImg;
  var biderName;
  var biderImg;
  var biderid;
  var proid;
  // var acceptedTime;
  MyListingProgress({
    Key? key,
    this.bathroom,
    this.category,
    this.description,
    this.garage,
    this.kitchen,
    this.room,
    this.type,
    this.location,
    this.videoUrl,
    this.price,
    this.houseid,
    this.Status,
    this.bidAmount,
    this.firstName,
    this.ApproveTime,
    this.userId,
    this.shouseid,
    this.sellerId,
    this.text,
    this.userImg,
    this.biderName,
    this.biderImg,
    this.biderid,
    this.proid,
    //  this.acceptedTime,

    //this.AcceptedTime,
  }) : super(key: key);

  @override
  State<MyListingProgress> createState() => _MyListingProgressState();
}

class _MyListingProgressState extends State<MyListingProgress> {
  @override
  Widget build(BuildContext context) {
    Color timelineColor =
        widget.Status != 'Pending' ? CustomColors.green : Colors.grey;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        leading: CustomBackButton(
          color: Colors.black,
          size: Size(1, 1),
        ),
        title: TextWidget(
          textSize: 23,
          text: "My Listing Details",
          color: Colors.black,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.240,
              width: MediaQuery.of(context).size.width * 0.924,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.02),
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
                          text: "\$ " + widget.price,
                          color: CustomColors.green,
                          textSize: 17,
                          isTitle: true,
                        )
                      ],
                    ),
                    Row(
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
                              width: 3,
                            ),
                            Text(
                              widget.room,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 28,
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
                          width: 28,
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
                              widget.kitchen,
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
            SizedBox(
              height: 11,
            ),
            Card(
              margin: EdgeInsets.only(top: 12, left: 15, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              color: Colors.white,
              child: ListTile(
                  contentPadding: EdgeInsets.only(left: 8, bottom: 1, right: 8),
                  title: TextWidget(
                    text: 'Accepted Bid',
                    color: Colors.black,
                    textSize: 16,
                    isTitle: true,
                  ),
                  subtitle: Text('By ' + widget.firstName,
                      style: TextStyle(color: Colors.grey)),
                  trailing: TextWidget(
                    text: "\$ " + widget.bidAmount,
                    color: CustomColors.green,
                    textSize: 17,
                    isTitle: true,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 23, right: 29),
                child: Column(children: [
                  TimelineTile(
                      nodeAlign: TimelineNodeAlign.start,
                      mainAxisExtent: 120,
                      direction: Axis.vertical,
                      contents: Container(
                        margin: EdgeInsets.only(top: 9, left: 12),
                        child: ListTile(
                          trailing: Image.asset(
                            "assets/svgexport-7 (31) 1.png",
                            color: timelineColor,
                          ),
                          title: TextWidget(
                            text: "Bid Approved",
                            textSize: 18,
                            isTitle: true,
                            color: Colors.black,
                          ),
                          subtitle: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('bids')
                                .where('houseid', isEqualTo: widget.houseid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return TextWidget(
                                  text: "Loading...",
                                  maxLine: 1,
                                  textSize: 12,
                                  isTitle: true,
                                  color: Color(0xff929292),
                                );
                              }
                              var bidDocs = snapshot.data?.docs;
                              var bidStatus =
                                  bidDocs != null && bidDocs.isNotEmpty
                                      ? bidDocs[0]['Status']
                                      : "Not Approved";
                              var acceptedTime = "";
                              if (bidStatus == "Accepted") {
                                var acceptedTimeStamp =
                                    bidDocs![0]['ApproveTie'] as Timestamp?;
                                var acceptedDateTime =
                                    acceptedTimeStamp?.toDate();
                                acceptedTime = acceptedDateTime != null
                                    ? DateFormat('dd MMM, hh:mm a')
                                        .format(acceptedDateTime)
                                    : "Bid accepted time not found";
                              } else {
                                acceptedTime = "Bid not yet approved";
                              }

                              return TextWidget(
                                text: acceptedTime,
                                maxLine: 1,
                                textSize: 12,
                                isTitle: true,
                                color: Color(0xff929292),
                              );
                            },
                          ),
                        ),
                      ),
                      node: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: TimelineNode(
                          indicator: Container(
                            height: MediaQuery.of(context).size.width * 0.07,
                            width: MediaQuery.of(context).size.width * 0.07,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.green,
                            ),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                          endConnector: Dash(
                              direction: Axis.vertical,
                              length: 39,
                              dashLength: 8,
                              dashGap: 12,
                              dashColor: timelineColor,
                              dashBorderRadius: 4,
                              dashThickness: 8),
                        ),
                      )),

                  // StreamBuilder<QuerySnapshot>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('payment')
                  //         .where('userId', isEqualTo: widget.userId)
                  //         .where('houseid', isEqualTo: widget.houseid)
                  //         .snapshots(),
                  //   builder: (context, snapshot) {
                  //
                  //     return TimelineTile(
                  //         nodeAlign: TimelineNodeAlign.start,
                  //         mainAxisExtent: 120,
                  //         direction: Axis.vertical,
                  //         contents: Container(
                  //           margin: EdgeInsets.only(
                  //               top: 9,
                  //               left: 12
                  //           ),
                  //           child: ListTile(
                  //             trailing: Image.asset(
                  //               "assets/payment.png",  ),
                  //             title: TextWidget(
                  //               text: "Waiting for Buyer",
                  //               textSize: 18,
                  //               isTitle: true,
                  //               color: Colors.black,
                  //             ),
                  //
                  //           ),
                  //         ),
                  //         node: Container(
                  //           height: MediaQuery
                  //               .of(context)
                  //               .size
                  //               .height * 0.25,
                  //
                  //           child: TimelineNode(
                  //             indicator: Container(
                  //               height: MediaQuery
                  //                   .of(context)
                  //                   .size
                  //                   .width * 0.07,
                  //               width: MediaQuery
                  //                   .of(context)
                  //                   .size
                  //                   .width * 0.07,
                  //               decoration: BoxDecoration(
                  //                 shape: BoxShape.circle,
                  //                 color: timelineColor,
                  //               ),
                  //               child: Icon(Icons.done,color: Colors.white,),
                  //             ),
                  //             startConnector: Dash(
                  //                 direction: Axis.vertical,
                  //                 length: 39,
                  //                 dashLength: 8,
                  //                 dashGap: 12,
                  //                 dashColor: timelineColor,
                  //                 dashBorderRadius: 4,
                  //                 dashThickness: 8),
                  //             endConnector: Dash(
                  //                 direction: Axis.vertical,
                  //                 length: 39,
                  //                 dashLength: 8,
                  //                 dashGap: 12,
                  //                 dashColor: Colors.grey,
                  //                 dashBorderRadius: 4,
                  //                 dashThickness: 8),
                  //           ),
                  //         )
                  //     );
                  //   }
                  // ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('payment')
                        .where('paymentType', isEqualTo: "Buyer")
                        // .where("userId",isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        .where('houseid', isEqualTo: widget.houseid)


                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        final paymentData = snapshot.data!.docs.first.data();

                        final String? paymentStatus =
                            paymentData is Map<String, dynamic>
                                ? paymentData['PayStatus'] as String?
                                : null;
                        final String? paymentType =
                            paymentData is Map<String, dynamic>
                                ? paymentData['paymentType'] as String?
                                : null;
                        final isPaid =
                            paymentStatus == 'Paid' && paymentType == 'Buyer';
                        final timelineColor =
                            isPaid ? CustomColors.green : Colors.grey;
                        final paymentText =
                            isPaid ? 'Buyer Responsed' : 'Payment Pending';
                        final buttonText = isPaid ? 'Pay time' : 'Pay';
                        Timestamp timestamp =
                            snapshot.data?.docs[0]["paymentDate"];
                        DateTime date = timestamp.toDate();
                        String formattedDateTime =
                            DateFormat('MMMM d, hh:mm a').format(date);

                        return Column(
                          children: [
                            TimelineTile(
                              nodeAlign: TimelineNodeAlign.start,
                              mainAxisExtent: 120,
                              direction: Axis.vertical,
                              contents: Container(
                                margin: EdgeInsets.only(top: 9, left: 12),
                                child: ListTile(
                                  trailing: Image.asset(
                                    "assets/payment.png",
                                    color: isPaid
                                        ? CustomColors.green
                                        : Colors.grey,
                                  ),
                                  subtitle: Text(formattedDateTime),
                                  title: TextWidget(
                                    text: paymentText,
                                    textSize: 18,
                                    isTitle: true,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              node: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: TimelineNode(
                                  indicator: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: timelineColor,
                                    ),
                                    child:
                                        Icon(Icons.done, color: Colors.white),
                                  ),
                                  startConnector: Dash(
                                    direction: Axis.vertical,
                                    length: 39,
                                    dashLength: 8,
                                    dashGap: 12,
                                    dashColor: timelineColor,
                                    dashBorderRadius: 4,
                                    dashThickness: 8,
                                  ),
                                  endConnector: Dash(
                                    direction: Axis.vertical,
                                    length: 39,
                                    dashLength: 8,
                                    dashGap: 12,
                                    dashColor: isPaid
                                        ? CustomColors.green
                                        : Colors.grey,
                                    dashBorderRadius: 4,
                                    dashThickness: 8,
                                  ),
                                ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('payment')

                                    .where('paymentType', isEqualTo: "Seller")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    final paymentData =
                                        snapshot.data!.docs.first.data();

                                    final String? paymentStatus = paymentData
                                            is Map<String, dynamic>
                                        ? paymentData['PayStatus'] as String?
                                        : null;
                                    final String? paymentType = paymentData
                                            is Map<String, dynamic>
                                        ? paymentData['paymentType'] as String?
                                        : null;
                                    final isPaid = paymentStatus == 'Paid' &&
                                        paymentType == 'Seller';
                                    final timelineColor = isPaid
                                        ? CustomColors.green
                                        : Colors.grey;
                                    final paymentText = isPaid
                                        ? 'Payment Paid'
                                        : 'Payment Pending';
                                    final buttonText =
                                        isPaid ? 'Pay time' : 'Pay';
                                    Timestamp timestamp =
                                        snapshot.data?.docs[0]["paymentDate"];
                                    DateTime date = timestamp.toDate();
                                    String formattedDateTime =
                                        DateFormat('MMMM d, hh:mm a')
                                            .format(date);

                                    return Column(
                                      children: [
                                        TimelineTile(
                                            nodeAlign: TimelineNodeAlign.start,
                                            mainAxisExtent: 120,
                                            direction: Axis.vertical,
                                            contents: Container(
                                                margin: EdgeInsets.only(
                                                    top: 9, left: 12),
                                                child: ListTile(
                                                  trailing: Image.asset(
                                                      "assets/Vector.png",
                                                      color: isPaid
                                                          ? CustomColors.green
                                                          : Colors.grey),
                                                  title: TextWidget(
                                                    text: paymentText,
                                                    textSize: 18,
                                                    isTitle: true,
                                                    color: Colors.black,
                                                  ),
                                                  subtitle: Text(formattedDateTime)
                                                )),
                                            node: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              child: TimelineNode(
                                                indicator: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: timelineColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                startConnector: Dash(
                                                    direction: Axis.vertical,
                                                    length: 39,
                                                    dashLength: 8,
                                                    dashGap: 12,
                                                    dashColor: timelineColor,
                                                    dashBorderRadius: 4,
                                                    dashThickness: 8),
                                                endConnector: Dash(
                                                    direction: Axis.vertical,
                                                    length: 39,
                                                    dashLength: 8,
                                                    dashGap: 12,
                                                    dashColor: timelineColor,
                                                    dashBorderRadius: 4,
                                                    dashThickness: 8),
                                              ),
                                            )),
                                        TimelineTile(
                                            nodeAlign: TimelineNodeAlign.start,
                                            mainAxisExtent: 120,
                                            direction: Axis.vertical,
                                            contents: Container(
                                              margin: EdgeInsets.only(top: 9, left: 12),
                                              child: ListTile(
                                                trailing: Image.asset("assets/connect.png",color: timelineColor,),
                                                title: TextWidget(
                                                  text: "Connection Made",
                                                  textSize: 18,
                                                  isTitle: true,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            node: Container(
                                              height: MediaQuery.of(context).size.height * 0.25,
                                              child: TimelineNode(
                                                indicator: Container(
                                                  height: MediaQuery.of(context).size.width * 0.07,
                                                  width: MediaQuery.of(context).size.width * 0.07,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: timelineColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.done,color: Colors.white,
                                                  ),
                                                ),
                                                startConnector: Dash(
                                                    direction: Axis.vertical,
                                                    length: 39,
                                                    dashLength: 8,
                                                    dashGap: 12,
                                                    dashColor: timelineColor,
                                                    dashBorderRadius: 4,
                                                    dashThickness: 8),
                                              ),
                                            )),
                                        ElevatedButton(
                                          onPressed: (){

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                  biderImg: widget.biderImg,
                                                  houseid: widget.houseid,
                                                  userId: widget.userId,
                                                  userImg: widget.userImg,
                                                  firstName: widget.firstName,
                                                  biderName: widget.biderName,
                                                  proid: widget.proid,

                                                )));
                                            print(widget.houseid);
                                            print(widget.firstName);
                                            print(widget.biderName);
                                            print(widget.proid);
                                            print(widget.userId);

                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff099E80),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  12.0), // 20 is the radius of the circular shape
                                            ),
                                            minimumSize: Size(240, 49), // set the width and height
                                          ),
                                          child: Text(
                                            'Chat',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        TimelineTile(
                                            nodeAlign: TimelineNodeAlign.start,
                                            mainAxisExtent: 120,
                                            direction: Axis.vertical,
                                            contents: Container(
                                                margin: EdgeInsets.only(
                                                    top: 9, left: 12),
                                                child: ListTile(
                                                  trailing: Image.asset(
                                                      "assets/Vector.png",
                                                      color: isPaid
                                                          ? CustomColors.green
                                                          : Colors.grey),
                                                  title: TextWidget(
                                                    text: "Payment Pending",
                                                    textSize: 18,
                                                    isTitle: true,
                                                    color: Colors.black,
                                                  ),
                                                  subtitle: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 2,
                                                        right:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.35),
                                                    child: ElevatedButton(
                                                      onPressed: paymentStatus ==
                                                              'Paid'
                                                          ? () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      PaymentSelections(
                                                                    userId: widget
                                                                        .userId,
                                                                    houseid: widget
                                                                        .houseid,
                                                                    price: widget
                                                                        .price,
                                                                    text:
                                                                        widget.text,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          : null, // Set onPressed to null when status is not approved
                                                      child: Text(
                                                        "Pay",
                                                        maxLines: 1,
                                                      ),
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                        primary: CustomColors
                                                            .green, // Update color based on status
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                        ),
                                                        minimumSize: Size(40, 26),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            node: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              child: TimelineNode(
                                                indicator: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isPaid
                                                        ? CustomColors.green
                                                        : Colors.grey,
                                                  ),
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                startConnector: Dash(
                                                    direction: Axis.vertical,
                                                    length: 39,
                                                    dashLength: 8,
                                                    dashGap: 12,
                                                    dashColor: isPaid
                                                        ? CustomColors.green
                                                        : Colors.grey,
                                                    dashBorderRadius: 4,
                                                    dashThickness: 8),
                                                endConnector: Dash(
                                                    direction: Axis.vertical,
                                                    length: 39,
                                                    dashLength: 8,
                                                    dashGap: 12,
                                                    dashColor: Colors.grey,
                                                    dashBorderRadius: 4,
                                                    dashThickness: 8),
                                              ),
                                            )),
                                        TimelineTile(
                                            nodeAlign: TimelineNodeAlign.start,
                                            mainAxisExtent: 120,
                                            direction: Axis.vertical,
                                            contents: Container(
                                              margin: EdgeInsets.only(top: 9, left: 12),
                                              child: ListTile(
                                                trailing: Image.asset("assets/connect.png"),
                                                title: TextWidget(
                                                  text: "Connection Made",
                                                  textSize: 18,
                                                  isTitle: true,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            node: Container(
                                              height: MediaQuery.of(context).size.height * 0.25,
                                              child: TimelineNode(
                                                indicator: Container(
                                                  height: MediaQuery.of(context).size.width * 0.07,
                                                  width: MediaQuery.of(context).size.width * 0.07,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey,
                                                  ),
                                                  child: Icon(
                                                    Icons.done,
                                                  ),
                                                ),
                                                startConnector: Dash(
                                                    direction: Axis.vertical,
                                                    length: 39,
                                                    dashLength: 8,
                                                    dashGap: 12,
                                                    dashColor: Colors.grey,
                                                    dashBorderRadius: 4,
                                                    dashThickness: 8),
                                              ),
                                            )),
                                        ElevatedButton(
                                          onPressed: null,
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff099E80),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  12.0), // 20 is the radius of the circular shape
                                            ),
                                            minimumSize: Size(240, 49), // set the width and height
                                          ),
                                          child: Text(
                                            'Chat',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            TimelineTile(
                              nodeAlign: TimelineNodeAlign.start,
                              mainAxisExtent: 120,
                              direction: Axis.vertical,
                              contents: Container(
                                margin: EdgeInsets.only(top: 9, left: 12),
                                child: ListTile(
                                  trailing: Image.asset(
                                    "assets/payment.png",
                                    color: Colors.grey,
                                  ),
                                  subtitle: Text("Waiting For Buyer"),
                                  title: TextWidget(
                                    text: "Buyer not pay Yet",
                                    textSize: 18,
                                    isTitle: true,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              node: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: TimelineNode(
                                  indicator: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: timelineColor,
                                    ),
                                    child:
                                        Icon(Icons.done, color: Colors.white),
                                  ),
                                  startConnector: Dash(
                                    direction: Axis.vertical,
                                    length: 39,
                                    dashLength: 8,
                                    dashGap: 12,
                                    dashColor: timelineColor,
                                    dashBorderRadius: 4,
                                    dashThickness: 8,
                                  ),
                                  endConnector: Dash(
                                    direction: Axis.vertical,
                                    length: 39,
                                    dashLength: 8,
                                    dashGap: 12,
                                    dashColor: Colors.grey,
                                    dashBorderRadius: 4,
                                    dashThickness: 8,
                                  ),
                                ),
                              ),
                            ),
                            TimelineTile(
                                nodeAlign: TimelineNodeAlign.start,
                                mainAxisExtent: 120,
                                direction: Axis.vertical,
                                contents: Container(
                                    margin: EdgeInsets.only(top: 9, left: 12),
                                    child: ListTile(
                                      trailing: Image.asset("assets/Vector.png",
                                          color: Colors.grey),
                                      title: TextWidget(
                                        text: "Payment Pending",
                                        textSize: 18,
                                        isTitle: true,
                                        color: Colors.black,
                                      ),
                                      subtitle: Container(
                                        margin: EdgeInsets.only(
                                            left: 2,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35),
                                        child: ElevatedButton(
                                          onPressed:
                                              null, // Set onPressed to null when status is not approved
                                          child: Text(
                                            "Pay",
                                            maxLines: 1,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: CustomColors
                                                .green, // Update color based on status
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            minimumSize: Size(40, 26),
                                          ),
                                        ),
                                      ),
                                    )),
                                node: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  child: TimelineNode(
                                    indicator: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                    startConnector: Dash(
                                        direction: Axis.vertical,
                                        length: 39,
                                        dashLength: 8,
                                        dashGap: 12,
                                        dashColor: Colors.grey,
                                        dashBorderRadius: 4,
                                        dashThickness: 8),
                                    endConnector: Dash(
                                        direction: Axis.vertical,
                                        length: 39,
                                        dashLength: 8,
                                        dashGap: 12,
                                        dashColor: Colors.grey,
                                        dashBorderRadius: 4,
                                        dashThickness: 8),
                                  ),
                                )),
                            TimelineTile(
                                nodeAlign: TimelineNodeAlign.start,
                                mainAxisExtent: 120,
                                direction: Axis.vertical,
                                contents: Container(
                                  margin: EdgeInsets.only(top: 9, left: 12),
                                  child: ListTile(
                                    trailing: Image.asset("assets/connect.png"),
                                    title: TextWidget(
                                      text: "Connection Made",
                                      textSize: 18,
                                      isTitle: true,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                node: Container(
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  child: TimelineNode(
                                    indicator: Container(
                                      height: MediaQuery.of(context).size.width * 0.07,
                                      width: MediaQuery.of(context).size.width * 0.07,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Icon(
                                        Icons.done,
                                      ),
                                    ),
                                    startConnector: Dash(
                                        direction: Axis.vertical,
                                        length: 39,
                                        dashLength: 8,
                                        dashGap: 12,
                                        dashColor: Colors.grey,
                                        dashBorderRadius: 4,
                                        dashThickness: 8),
                                  ),
                                )),
                            ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff099E80),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // 20 is the radius of the circular shape
                                ),
                                minimumSize: Size(240, 49), // set the width and height
                              ),
                              child: Text(
                                'Chat',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),


                ])),

            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
