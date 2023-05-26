import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_listing_bids/my_listing_bid_detail.dart';

import '../../../conts/Color.dart';
import '../../../widgets/button_text.dart';

class MyBidingListWidgets extends StatelessWidget {
  const MyBidingListWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.push (
        //   context,
        //   MaterialPageRoute (
        //     builder: (BuildContext context) => MyLisstingBidDetail(),
        //   ),
        // );
      },
      child: Card(
        elevation: 1,
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5,right: 12,bottom: 7,top: 8),
          leading: Image.asset(
            'assets/Rectangle 817.png',height: 88,
            fit: BoxFit.fill,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: TextWidget(
                      text:'The Gables House',
                      textSize: 16,
                      color: Colors.black,
                      isTitle: true,
                      maxLine: 1,
                    ),
                  ),Flexible(
                    flex: 3,
                    child: TextWidget(
                      text:'\$ 178,000 ',
                      textSize: 16,
                      color: CustomColors.green,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              TextWidget(
                text:'4517 Washington Ave, Street Machester, Srandol ',
                textSize: 10,
                color: Color(0xff828282),
              ),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Highest Bid:',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: ' \$ 139,000 ', style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffFF9B42),
                        fontWeight: FontWeight.bold)),

                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}
