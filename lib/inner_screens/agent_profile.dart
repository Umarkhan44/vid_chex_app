import 'package:flutter/material.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/inner_screens/other_listing_agent_profile.dart';
import 'package:vid_chex_app/widgets/for_listView_widget.dart';

import '../widgets/back_button.dart';
import '../widgets/button_text.dart';

class AgentProfile extends StatelessWidget {
  var userImg;
  var firstName;
  var about;
   AgentProfile({Key? key,
    required this.userImg,
    required this.firstName,
     required this.about
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: CustomBackButton(color: Colors.black, size: Size.infinite),
        title: TextWidget(
          textSize: 22,
          text: "Agent Profile",
          color: Colors.black,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 9, top: 3, right: 5),
              margin: EdgeInsets.only(left: 22, right: 19, top: 20),
              height: MediaQuery.of(context).size.height * 0.54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Image.network(userImg),
                    contentPadding: EdgeInsets.only(left: 8, bottom: 1, right: 8),
                    title: TextWidget(
                      text: firstName,
                      color: Colors.black,
                      textSize: 16,
                      isTitle: true,
                    ),
                    subtitle: Text(
                      'View Agent Profile',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextWidget(
                    text: "Information",
                    color: Colors.black,
                    textSize: 18,
                    isTitle: true,
                  ),
                  Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff099E80)
                              .withOpacity(0.3) // or any other color you want
                          ),
                      child: Icon(
                        Icons.email_outlined,
                        color: Colors.green,
                        size: 12,
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff099E80)
                                  .withOpacity(0.3) // or any other color you want
                              ),
                          child: Icon(
                            Icons.home,
                            color: Colors.green,
                            size: 12,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '10',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextWidget(
                    text: "About Me",
                    color: Colors.black,
                    textSize: 14,
                    isTitle: true,
                  ),
                  TextWidget(
                    text:about,

                    color: Colors.grey,
                    textSize: 10,
                   maxLine: 6,
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: null,
                      child: TextWidget(
                        color: Colors.white,
                        text: "Chat",
                        textSize: 17,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            CustomColors.green.withOpacity(0.3)),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 80, vertical: 6),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 31,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: TextWidget(
                text: "Other Listings",
                color: Color(0xff323643),
                textSize: 20,
                isTitle: true,
              ),
            ),

            ListView.builder(
              padding: EdgeInsets.only(left: 14),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:  EdgeInsets.only(top: 11),
                  child: OtherListing(),
                );

              },

            ),
          ],
        ),
      ),
    );
  }
}
