import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/my_bid_screen/my_listing_bids/my_listings.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../../widgets/for_listView_widget.dart';
import 'my_bidings.dart';

class MyBidingTabBar extends StatefulWidget {
  MyBidingTabBar({Key? key}) : super(key: key);

  @override
  State<MyBidingTabBar> createState() => _MyBidingsState();
}

class _MyBidingsState extends State<MyBidingTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Image.asset(
          "assets/dararicon.png",
          color: Colors.black,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 18, bottom: 16),
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 42,
            child: Icon(Icons.search),
          ),
          25.0.sh
        ],
        title: Align(
            alignment: Alignment.centerLeft,
            widthFactor: 1,
            child: TextWidget(
              text: "Bids",
              color: CustomColors.green,
              textSize: 23,
              isTitle: true,
            )),
        // Decrease the preferredSize height to reduce the gap between title and leading
        //preferredSize: Size.fromHeight(kToolbarHeight * 0.8),
        toolbarHeight: kToolbarHeight * 1.3,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 23, right: 23),
            height: 48,
            //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: CustomColors.green,
                width: 2.0,
              ),
            ),
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: CustomColors.green,
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(
                //   color: CustomColors.green,
                //   width: 2.0,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.3),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              tabs: [
                Tab(
                  child: Center(
                    child: Text(
                      'My Bids',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      'My Listings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MyBidings(),
                MyListings()
              ],
            ),
          ),
        ],
      ),
    );
  }

}
extension SizedBoxWidthExtension on double {
  SizedBox get sw => SizedBox(width: this);
}

extension SizedBoxHeightExtension on double {
  SizedBox get sh => SizedBox(height: this);
}