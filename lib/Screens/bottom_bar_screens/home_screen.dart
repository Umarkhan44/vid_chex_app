import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/inner_screens/house_detail.dart';
import 'package:vid_chex_app/widgets/button_text.dart';


import '../../inner_screens/see_all_house.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController searchController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
// Define a global variable to keep track of the number of notifications
  int notificationCount = 0;
  String search = "";
  double minPrice = 0.0;
  double maxPrice = double.infinity;

// Function to update the notification count
  void updateNotificationCount() {
    // Increment the notification count
    notificationCount += 1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.only(left: 21, right: 21),
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/vidchdex 1.png",
            ),
            Container(
              child: Badge(

                position: BadgePosition.custom(top: 12,end: 11),
                badgeContent: Text('$notificationCount', style: TextStyle(color: Colors.white,fontSize: 5),),

                child: IconButton(
                  icon: Icon(Icons.notifications,size: 23,),
                  onPressed: () {
                    // Navigate to the notification screen when the notification icon is pressed
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          onChanged: (value){
            setState(() {
              search = value;
            });
          },
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            suffixIcon: InkWell(
              onTap: (){
          setState(() {
          minPrice = double.parse(minPriceController.text);
          maxPrice = double.parse(maxPriceController.text);
          });
          },
                child: Icon(Icons.search)),
            border: InputBorder.none,
          ),
        ),
        SizedBox(
          height: 22,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: "House Near by ",
                color: Colors.black,
                textSize: 20,
                isTitle: true,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SeeAllHouses(),
                    ),
                  );
                },
                child: Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: CustomColors.green),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 14,
        ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (search != "" && search != '')
                        ? FirebaseFirestore.instance
                        .collection('house')
                        .where("price",
                        isGreaterThanOrEqualTo: search)
                        .snapshots()
                        : FirebaseFirestore.instance
                          .collection('house')
                          .where('providedBy',
                          isNotEqualTo: user!
                              .uid) // exclude houses added by the current user
                          .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text("No houses found"),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          final house = snapshot.data!.docs[index];
                          return Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () async {

                                final userSnapshot = await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(house['providedBy'])
                                    .get();
                                final userData = userSnapshot.data()!;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => HouseDetail(
                                      bathroom: house['bathroom'],
                                      category: house['category'],
                                      description: house['description'],
                                      garage: house['garage'],
                                      kitchen: house['kitchen'],
                                      room: house['room'],
                                      type: house['type'],
                                      price: house['price'],
                                      location: house['location'],
                                      videoUrl: house['videoUrl'],
                                      firstName: userData['firstName'],
                                      userImg: userData['userImg'],
                                      about: userData['about'],
                                      houseid: house['houseid'],
                                      proid: house['providedBy'],
                                      // Status: house['Status'],
                                      // timestamp: house['timestamp'],
                                      // AcceptedTime: house['AcceptedTime'],
                                    ),
                                  ),
                                );
                                print("price price price price ${house['providedBy']}");
                                print("dgghdhdhdhfhffhfh${userData['providedBy']}");
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.only(
                                  left: 5,
                                  right: 12,
                                  bottom: 7,
                                ),
                                leading: Image.asset(
                                  'assets/Rectangle 817.png',
                                  height: 88,
                                  fit: BoxFit.fill,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextWidget(
                                      text: house['type'],
                                      textSize: 16,
                                      color: Colors.black,
                                      isTitle: true,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextWidget(
                                      text: house[
                                      'location'], // use house address from Firebase
                                      textSize: 10,
                                      color: Color(0xff828282),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextWidget(
                                      text:
                                      '\$ ${house['price']}  ', // use house price from Firebase
                                      textSize: 16,
                                      color: CustomColors.green,
                                      isTitle: true,
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: CustomColors.green,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )

                ]),
    )));
  }
}
