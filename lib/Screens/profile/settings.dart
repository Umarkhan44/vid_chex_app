import 'package:flutter/material.dart';
import 'package:vid_chex_app/screens/profile/about.dart';
import 'package:vid_chex_app/screens/profile/terms_conditions.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../../widgets/back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
                horizontalTitleGap: 80,
                contentPadding: EdgeInsets.only(left: 20),
                leading: GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                ),
                title: TextWidget(
                  isTitle: true,
                  text: "Settings",
                  textSize: 20,
                  color: Colors.black,
                )
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
// Navigator.pushReplacement(context,
// MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              child: ListTile(
                leading: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffC4C4C4).withOpacity(0.5)
                      ,
                    ),
                    child: Icon(Icons.notifications_none,color: Colors.black,)),
                title: Text("Notifications Settings",
                  style: TextStyle(
                      fontSize: 15,color: Colors.black
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => TermConditions()));
              },
              child: ListTile(
                leading: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffC4C4C4).withOpacity(0.5)
                      ,
                    ),
                    child: Icon(Icons.text_snippet_outlined,color: Colors.black,)),
                title: Text("Terms & Conditions",
                  style: TextStyle(
                      fontSize: 15,color: Colors.black
                  ),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => About()));
              },
              child: ListTile(
                leading: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffC4C4C4).withOpacity(0.5)
                      ,
                    ),
                    child: Icon(Icons.info_outline,color: Colors.black,)),
                title: Text("About",
                  style: TextStyle(
                      fontSize: 15,color: Colors.black
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}