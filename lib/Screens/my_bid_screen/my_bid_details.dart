import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/progress_line.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../../inner_screens/agent_profile.dart';

class MyBidDetails extends StatefulWidget {
  var bathroom;
  var category;
  var descripti;
  var garage;
  var kitchen;
  var room;
  var type;
  var price;
 // var location;
 //  var videoUrl;
  var firstName;
   var userImg;
   var about;
   var bidAmount;
   var Status;
   var RequestTime;

   var uuid;
   var houseid;
   var userId;
   var paymentStatus;
   var payentDate;
   var ApproveTime;
   var proid;
   var biderName;

   var biderImg;

  //
  // var houseid;
  // var proid;
  MyBidDetails(
      {Key? key,
      required this.bathroom,
      required this.category,
      required this.descripti,
      required this.garage,
      required this.kitchen,
      required this.room,
      required this.type,
    // required this.location,
     //  required this.videoUrl,
      required this.price,
       required this.firstName,
       required this.userImg,
       required this.about,
       required this.bidAmount,
        required this.Status,
        required this.RequestTime,

        required this.uuid,
        this.houseid,
        this.userId,
        required this.paymentStatus,
        this.payentDate, required this.ApproveTime,
        this.proid, this.biderImg,
        this.biderName,


      // required this.houseid,
     // required this.proid
      })
      : super(key: key);

  @override
  State<MyBidDetails> createState() => _MyBidDetailsState();
}

class _MyBidDetailsState extends State<MyBidDetails> {

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
          text: "My Bid Details",
          color: Colors.black,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.all(12),
              child: ListTile(
                contentPadding:
                    EdgeInsets.only(right: 12, left: 10, top: 10, bottom: 10),
                leading: TextWidget(
                  text: "My Bid",
                  textSize: 18,
                  isTitle: true,
                  color: Colors.black,
                ),
                trailing: Text(
                  "\$ " + widget.bidAmount,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff099E80),
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 22,
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
                          text: "\$ " +widget.price,
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
                      text: widget.descripti,
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>  AgentProfile(
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
                    leading: Image.network(widget.userImg,width: 50,height: 51,),
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
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: CustomColors.green,
                          size: 19,
                        ))),
              ),
            ),
            ProgressLine(
              houseid:widget.houseid,
              userId:widget.userId,
              uuid:widget.uuid,
              price:widget.price,
              Status: widget.Status,
              ApproveTime: widget.ApproveTime,
              firstName: widget.firstName,
              userImg: widget.userImg,
              proid: widget.proid,
              biderImg: widget.biderImg,
              biderName: widget.biderName,

              paymentStatus:widget.paymentStatus,
              RequestTime: widget.RequestTime,

            //  payentDate: widget.payentDate,


            ),

            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
