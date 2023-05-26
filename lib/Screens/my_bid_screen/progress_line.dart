import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../chat/chat_page.dart';
import '../chat/check.dart';
import '../payements/payments_selections.dart';

class ProgressLine extends StatefulWidget {
  var RequestTime;
  var Status;
  var price;
  var uuid;
  var houseid;
  var userId;
  var paymentStatus;
  var ApproveTime;
  var payentDate;
  var firstName;
  var userImg;
  var proid;
  var biderImg;
  var biderName;

  ProgressLine({
    Key? key,
    this.Status,
    this.price,
    this.uuid,
    this.houseid,
    this.userId,
    this.paymentStatus,
    this.RequestTime,
    this.payentDate,
    this.ApproveTime,
    this.userImg,
    this.firstName,
    this.proid, this.biderImg, this.biderName,
  }) : super(key: key);

  @override
  State<ProgressLine> createState() => _ProgressLineState();
}

class _ProgressLineState extends State<ProgressLine> {
  bool isCollectionCreated = false; // Flag variable
  @override
  void initState() {
    print(widget.RequestTime);
    print(widget.ApproveTime);
    print(widget.Status);
    print(widget.price);
    print(widget.uuid);

    //print(widget.paymentStatus);
    Color timelineColor = widget.Status == 'Accepted'
        ? CustomColors.green
        : widget.paymentStatus == 'Paid'
            ? CustomColors.green
            : Colors.grey;
    print(timelineColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color timelineColor = widget.Status == 'Accepted'
        ? CustomColors.green
        : widget.paymentStatus == 'Paid'
            ? CustomColors.green
            : Colors.grey;

    return Padding(
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
                  "assets/Frame.png",
                  color: CustomColors.green,
                ),
                title: TextWidget(
                  text: "Bid Requested",
                  textSize: 18,
                  isTitle: true,
                  color: Colors.black,
                ),
                subtitle: TextWidget(
                  text: "Requested on '" + widget.RequestTime,
                  textSize: 12,
                  isTitle: true,
                  color: Color(0xff929292),
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
                    color:
                        CustomColors.green, // Update color based on condition
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
                  dashColor: CustomColors.green,
                  // Update color based on condition
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
                  subtitle: TextWidget(
                    text: widget.Status == "Pending"
                        ? "not bid yet Approved"
                        : widget.ApproveTime,
                    maxLine: 1,
                    textSize: 12,
                    isTitle: true,
                    color: Color(0xff929292),
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
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                  startConnector: Dash(
                      direction: Axis.vertical,
                      length: 39,
                      dashLength: 8,
                      dashGap: 12,
                      dashColor: CustomColors.green,
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
          // TimelineTile(
          //     nodeAlign: TimelineNodeAlign.start,
          //     mainAxisExtent: 120,
          //     direction: Axis.vertical,
          //     contents: Container(
          //         margin: EdgeInsets.only(
          //             top: 9,
          //             left: 12
          //         ),
          //         child: ListTile(
          //           trailing: Image.asset("assets/Vector.png",color: timelineColor,),
          //           title: TextWidget(
          //             text: "Payment Pending",
          //             textSize: 18,
          //             isTitle: true,
          //             color: Colors.black,
          //           ),
          //           subtitle: Container(
          //             margin: EdgeInsets.only(left: 2, right: MediaQuery
          //                 .of(context)
          //                 .size
          //                 .width * 0.35),
          //             child: ElevatedButton(
          //               onPressed: widget.Status == 'Accepted' ? () {
          //                 Navigator.push (
          //                   context,
          //                   MaterialPageRoute (
          //                     builder: (BuildContext context) =>  PaymentSelections(
          //                         price : widget.price,
          //                         houseid:widget.houseid,
          //                         userId:widget.userId,
          //                         uuid:widget.uuid
          //                     ),
          //                   ),
          //                 );
          //               } : null,
          //               // Set onPressed to null when status is not approved
          //               child: Text("Pay", maxLines: 1,),
          //               style: ElevatedButton.styleFrom(
          //                 primary: widget.Status == 'Accepted' ? CustomColors.green : Colors.grey, // Update color based on status
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 minimumSize: Size(40, 26),
          //               ),
          //             ),
          //           ),
          //
          //         )
          //
          //
          //     ),
          //
          //     node: Container(
          //       height: MediaQuery
          //           .of(context)
          //           .size
          //           .height * 0.25,
          //
          //       child: TimelineNode(
          //         indicator: Container(
          //           height: MediaQuery
          //               .of(context)
          //               .size
          //               .width * 0.07,
          //           width: MediaQuery
          //               .of(context)
          //               .size
          //               .width * 0.07,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: timelineColor,
          //           ),
          //           child: Icon(Icons.done, color: Colors.white,),
          //         ),
          //         startConnector: Dash(
          //             direction: Axis.vertical,
          //             length: 39,
          //             dashLength: 8,
          //             dashGap: 12,
          //             dashColor: timelineColor,
          //             dashBorderRadius: 4,
          //             dashThickness: 8),
          //         endConnector: Dash(
          //             direction: Axis.vertical,
          //             length: 39,
          //             dashLength: 8,
          //             dashGap: 12,
          //             dashColor: widget.paymentStatus == "Pending"? Colors.grey:CustomColors.green,
          //             dashBorderRadius: 4,
          //             dashThickness: 8),
          //       ),
          //     )
          // ),

          TimelineTile(
              nodeAlign: TimelineNodeAlign.start,
              mainAxisExtent: 120,
              direction: Axis.vertical,
              contents: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('payment')
                    .where('paymentType', isEqualTo: 'Buyer')
                    .where('houseid', isEqualTo: widget.houseid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final paymentData = snapshot.data!.docs.first.data();

                    final String? paymentStatus =
                        paymentData is Map<String, dynamic>
                            ? paymentData['PayStatus'] as String?
                            : null;
                    final isPaid = paymentStatus == 'Paid';
                    final timelineColor =
                        isPaid ? CustomColors.green : Colors.grey;
                    final paymentText =
                        isPaid ? 'Buyer Responded' : 'Waiting for buyer';
                    // final Timestamp paymentTimestamp = paymentData['paymentDate'];
                    Timestamp timestamp = snapshot.data?.docs[0]["paymentDate"];
                    DateTime date = timestamp.toDate();

                    // Format the date
                    String formattedDate = DateFormat.yMMMMd().format(date);

                    // Format the time
                    String formattedTime = DateFormat.Hm().format(date);

                    // Combine the formatted date and time
                    String formattedDateTime = '$formattedDate $formattedTime';

                    return Container(
                      margin: EdgeInsets.only(left: 12, top: 9),
                      child: ListTile(
                        trailing: Image.asset(
                          "assets/Vector.png",
                          color: timelineColor,
                        ),
                        title: TextWidget(
                          text: isPaid ? "Payment Paid" : "Payment Pending",
                          textSize: 18,
                          isTitle: true,
                          color: Colors.black,
                        ),
                        subtitle: isPaid
                            ? TextWidget(
                                text: formattedDateTime != null
                                    ? formattedDateTime
                                    : "",
                                textSize: 12,
                                isTitle: true,
                                color: Colors.black54,
                              )
                            : ElevatedButton(
                                onPressed: widget.Status == 'Accepted'
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PaymentSelections(
                                              price: widget.price,
                                              houseid: widget.houseid,
                                              userId: widget.userId,
                                              uuid: widget.uuid,
                                              text: "Buyer",
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                                // Set onPressed to null when status is not approved
                                child: Text(
                                  "Pay",
                                  maxLines: 1,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: widget.Status == 'Accepted'
                                      ? CustomColors.green
                                      : Colors
                                          .grey, // Update color based on status
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: Size(40, 26),
                                ),
                              ),
                      ),
                    );
                  } else {
                    return Container(
                        margin: EdgeInsets.only(top: 9, left: 12),
                        child: ListTile(
                          trailing: Image.asset(
                            "assets/Vector.png",
                            color: timelineColor,
                          ),
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
                                    MediaQuery.of(context).size.width * 0.35),
                            child: ElevatedButton(
                              onPressed: widget.Status == 'Accepted'
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PaymentSelections(
                                                  text: "Buyer",
                                                  price: widget.price,
                                                  houseid: widget.houseid,
                                                  userId: widget.userId,
                                                  uuid: widget.uuid),
                                        ),
                                      );
                                    }
                                  : null,
                              // Set onPressed to null when status is not approved
                              child: Text(
                                "Pay",
                                maxLines: 1,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: widget.Status == 'Accepted'
                                    ? CustomColors.green
                                    : Colors
                                        .grey, // Update color based on status
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(40, 26),
                              ),
                            ),
                          ),
                        ));
                  }
                },
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
                    dashThickness: 8,
                  ),
                  endConnector: Dash(
                      direction: Axis.vertical,
                      length: 39,
                      dashLength: 8,
                      dashGap: 12,
                      dashColor: widget.paymentStatus == "Pending"
                          ? Colors.grey
                          : CustomColors.green,
                      dashBorderRadius: 4,
                      dashThickness: 8),
                ),
              )),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('payment')
                  .where('paymentType', isEqualTo: "Seller")
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
                      paymentStatus == 'Paid' && paymentType == 'Seller';
                  final timelineColor =
                      isPaid ? CustomColors.green : Colors.grey;
                  final paymentText =
                      isPaid ? 'Seller Responded' : "Waiting for Seller";
                  final buttonText = isPaid ? 'Pay time' : 'Pay';
                  Timestamp timestamp = snapshot.data?.docs[0]["paymentDate"];
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
                              trailing: Image.asset("assets/payment.png",
                                  color: timelineColor),
                              title: TextWidget(
                                text: paymentText,
                                textSize: 18,
                                isTitle: true,
                                color: Colors.black,
                              ),subtitle: Text(formattedDateTime),
                            ),
                          ),
                          node: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: TimelineNode(
                              indicator: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                width: MediaQuery.of(context).size.width * 0.07,
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
                                  dashColor: CustomColors.green,
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
                              trailing: Image.asset(
                                "assets/connect.png",
                                color: Colors.grey,
                              ),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
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
                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                userImg: widget.userImg,
                                biderName: widget.biderName,

                                houseid: widget.houseid,
                                userId: widget.userId,
                                firstName: widget.firstName,
                                proid: widget.proid,
                                biderImg: widget.biderImg,
                              ),
                            ),
                          );

                          // Create a collection in Firestore for the chatUser if it hasn't been created already
                          if (!isCollectionCreated) {
                            FirebaseFirestore.instance.collection('chatUser').add({
                              'userImg': widget.userImg,
                              'houseid': widget.houseid,
                              'userId': widget.userId,
                              'firstName': widget.firstName,
                            });
                            isCollectionCreated = true; // Set the flag variable to true
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff099E80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          minimumSize: Size(240, 49),
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
                            margin: EdgeInsets.only(top: 9, left: 12),
                            child: ListTile(
                              trailing: Image.asset("assets/payment.png",
                                  color: Colors.grey),
                              title: TextWidget(
                                text: "Waiting for Seller",
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
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                width: MediaQuery.of(context).size.width * 0.07,
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
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                width: MediaQuery.of(context).size.width * 0.07,
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
                          minimumSize:
                              Size(240, 49), // set the width and height
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
        ]));
  }
}
