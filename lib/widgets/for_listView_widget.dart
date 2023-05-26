import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vid_chex_app/inner_screens/house_detail.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../conts/Color.dart';

class ListItem extends StatefulWidget {
  final String userId;

  const ListItem({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("house").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No houses found"),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final house = snapshot.data!.docs[index];
            return InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => HouseDetail(
                //       bathroom: house['bathroom'],
                //       category: house['category'],
                //       description: house['description'],
                //       garage: house['garage'],
                //       kitchen: house['kitchen'],
                //       room: house['room'],
                //       type: house['type'],
                //       price: house['price'],
                //       location: house['location'],
                //       videoUrl: house['videoUrl'], firstName: '', userImg: null,
                //     ),
                //   ),
                // );
              },
              child: Card(
                elevation: 4,
                child: ListTile(
                  contentPadding:
                  EdgeInsets.only(left: 5, right: 12, bottom: 7),
                  leading: Image.asset(
                    'assets/Rectangle 817.png',
                    height: 88,
                    fit: BoxFit.fill,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextWidget(
                        text: house['price'],
                        textSize: 16,
                        color: Colors.black,
                        isTitle: true,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextWidget(
                        text: house['address'], // use house address from Firebase
                        textSize: 10,
                        color: Color(0xff828282),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextWidget(
                        text: '\$ ${house['price']}  ', // use house price from Firebase
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
    );

  }
}
