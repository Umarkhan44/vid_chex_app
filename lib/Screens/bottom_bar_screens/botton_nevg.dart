import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/add_house%20/add_new_house.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/home_screen.dart';
import 'package:vid_chex_app/Screens/chat/chat_screen.dart';
import 'package:vid_chex_app/Screens/profile/profile_screen.dart';
import 'package:vid_chex_app/conts/Color.dart';
import '../my_bid_screen/my_biding_tab_bar.dart';

class BottomNevigation extends StatefulWidget {
  final int initialIndex;
   BottomNevigation({Key? key,   required this.initialIndex,  }) : super(key: key);

  @override
  State<BottomNevigation> createState() => _BottomNevigationState();
}

class _BottomNevigationState extends State<BottomNevigation> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurvedNavBar(
        extendBody: true,
           activeColor: CustomColors.green,
        actionButton: CurvedActionBar(

            onTab: (value) {

              print(value);
            },
            activeIcon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AddNewHouse()));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration:
                BoxDecoration(color: CustomColors.green,shape: BoxShape.circle
                ),
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),

            text: "Camera",),



        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.home_filled,
                size: 27,
                color: Colors.black,
              ),
              inActiveIcon: Icon(
                Icons.house,
                size: 27,
                color: Colors.black,
              ),
              text: 'Home',),
          FABBottomAppBarItem(
            activeIcon: Image.asset("assets/auction (1) 1.png",color: Colors.green,),

            inActiveIcon: Image.asset("assets/auction (1) 1.png",color: Colors.black,),
            text: 'Bids',),
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.chat,
                size: 27,
                color: Colors.black,
              ),
              inActiveIcon: Icon(
                Icons.chat_bubble_outline,
                size: 27,
                color: Colors.black,
              ),
              text: 'Chat'),
          FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.account_circle_outlined,
                size: 27,
                color: Colors.black,
              ),
              inActiveIcon: Icon(
                Icons.account_circle_outlined,
                size: 27,
                color: Colors.black,
              ),
              text: 'Profile'),


        ],
        bodyItems: [
         HomeScreen(),
          MyBidingTabBar(),
          ChatScreen(),
          Profile()
        ],

      ),


    );
  }

}