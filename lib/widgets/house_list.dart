import 'package:flutter/material.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button_text.dart';


class HouseListWidgets extends StatelessWidget {
  final String bathroom;
  final String category;
  final String description;
  final String garage;
  final String kitchen;
  final String room;
  final String type;
  final String price;
  final String location;
  final String videoUrl;
  final String firstName;
  var userImg;

  HouseListWidgets({
    required this.bathroom,
    required this.category,
    required this.description,
    required this.garage,
    required this.kitchen,
    required this.room,
    required this.type,
    required this.price,
    required this.location,
    required this.videoUrl,
    required this.firstName,
    required this.userImg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.16,
            child: Image.network(
              userImg,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextWidget(
                text: category,
                textSize: 16,
                color: CustomColors.green,
                isTitle: true,
              ),
              SizedBox(
                height: 6,
              ),
              TextWidget(
                text: location,
                textSize: 10,
                color: Color(0xff828282),
              ),
              SizedBox(
                height: 6,
              ),
              TextWidget(
                text:' \$ $price',
                textSize: 16,
                color: CustomColors.green,
                isTitle: true,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
