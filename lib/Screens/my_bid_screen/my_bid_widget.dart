import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_bid_details.dart';

import '../../conts/Color.dart';
import '../../widgets/button_text.dart';

class MyBidWidget extends StatelessWidget {
  var bathroom;
  var category;
  // var descripti;
  // var garage;
  // var kitchen;
  // var room;
  // var type;
   var price;
   var location;
  // var videoUrl;
  // var firstName;
  // var userImg;
  //
  // var houseid;
  // var proid;
   var bidAmount;

   MyBidWidget(
      {Key? key,
      required this.bathroom,
      required this.category,
      // required this.descripti,
      // required this.garage,
      // required this.kitchen,
      // required this.room,
      // required this.type,
      required this.price,
       required this.location,
       required this.bidAmount,
      // required this.videoUrl,
      // required this.firstName,
      //   required this.houseid,
      //   required this.proid,
      //required this.userImg,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding:
            EdgeInsets.only(left: 5, right: 12, bottom: 7, top: 8),
        leading: Image.asset(
          'assets/Rectangle 817.png',
          height: 88,
          fit: BoxFit.fill,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: TextWidget(
                    text: category,
                    textSize: 16,
                    color: Colors.black,
                    isTitle: true,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: TextWidget(
                    text: price,
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
              text: location,
              textSize: 10,
              color: Color(0xff828282),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'My Bid:',
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: bidAmount,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffFF9B42),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
