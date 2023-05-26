import 'package:flutter/material.dart';

import '../conts/Color.dart';
import '../widgets/button_text.dart';

class OtherListing extends StatelessWidget {
  const OtherListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 5,bottom: 5),
          leading: Image.asset(
            'assets/Rectangle 817 (2).png',height: 88,
            fit: BoxFit.fill,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              TextWidget(
                text:'The Laurels House ',
                textSize: 16,
                color: Colors.black,
                isTitle: true,
              ),
              SizedBox(height: 6,),
              TextWidget(
                text:'4517 Washington Ave, Street Machester, Srandol ',
                textSize: 10,
                color: Color(0xff828282),
              ),
              SizedBox(height: 6,),
              TextWidget(
                text:'\$ 45170000  ',
                textSize: 16,
                color: CustomColors.green,isTitle: true,
              ),

            ],
          ),

        ),
        SizedBox(height: 10,),
        Divider(

          thickness: 1,
        )
      ],
    );
  }
}
