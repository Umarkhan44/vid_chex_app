import 'package:flutter/material.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../../widgets/back_button.dart';

class AppNotifications extends StatefulWidget {
  const AppNotifications({Key? key,}) : super(key: key);



  @override
  State<AppNotifications> createState() => _AppNotificationsState();
}

class _AppNotificationsState extends State<AppNotifications> {

  @override
  Widget build(BuildContext context) {
    bool _lights2 = true;
    bool _lights = false;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
                horizontalTitleGap: 80,
                contentPadding: EdgeInsets.only(left: 20),
                leading: CustomBackButton(
                  color: Colors.black,
                  size: Size(33,33),
                ),
                title: TextWidget(
                  isTitle: true,
                  text: "Settings",
                  textSize: 20,
                  color: Colors.black,
                )
            ),
            SwitchListTile(
              activeColor: Color(0xff48DF3B),
              title: const Text('App Notification'),
              value: _lights2,
              onChanged: (bool value) {
                setState(() {
                  _lights2 = value;
                });
              },

            ),
            SwitchListTile(
              title: const Text('Storage Notification'),
              value: _lights,
              onChanged: (bool value) {
                setState(() {
                  _lights = value;
                });
              },

            ),
          ],
        ),
      ),
    );
  }
}
