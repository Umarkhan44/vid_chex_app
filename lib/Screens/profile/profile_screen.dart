import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/auth_screens/login_screen.dart';
import 'package:vid_chex_app/Screens/profile/edit_profile.dart';
import 'package:vid_chex_app/Screens/profile/settings.dart';
import 'package:vid_chex_app/screens/profile/terms_conditions.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../../conts/Color.dart';

class Profile extends StatefulWidget {

  const Profile({Key? key, }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final String _userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("user").where('userid',isEqualTo: _userId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    // use `data` to render your widget
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                                color: Color(0xff000000)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(data['userImg']),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            data["firstName"],
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Color(0xff000000)),
                          ),

                          SizedBox(
                            height: 21,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                        LastName: data['LastName'],
                                        firstName: data['firstName'],
                                        userImg: data['userImg'],
                                        about: data['about'],
                                        email: data['email'],
                                        city: data['city'],
                                        country: data['country'],
                                        dateOfBirth: data['dateOfBirth'],

                                      )));
                            },
                            child: Text("Edit Profile"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(123, 36),
                              padding: EdgeInsets.all(8.0),
                              primary: CustomColors.green,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Color(0xffC4C4C4).withOpacity(0.4),
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                  textSize: 18,
                                  color: Colors.black,
                                  text: "Preferences",
                                  isTitle: true,
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => SettingsScreen()));
                            },
                            child: ListTile(
                              leading: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xffC4C4C4).withOpacity(0.5),
                                  ),
                                  child: Icon(Icons.settings)),
                              title: Text("Settings"),
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
                                    color: Color(0xffC4C4C4).withOpacity(0.5),
                                  ),
                                  child: Icon(Icons.help_outline)),
                              title: Text("Help"),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.grey.withOpacity(0.4),
                                        size: 43,
                                      ),
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 86,
                                        width: 86,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CustomColors.green
                                              .withOpacity(0.2),
                                        ),
                                        child: Image.asset(
                                          'assets/logout.png',
                                          height: 80,
                                          width: 90,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        'Are you sure you want to logout?',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      SizedBox(height: 30),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LogInScreen(),
                                            ),
                                          );
                                        },
                                        child: Text('Logout'),
                                        style: ElevatedButton.styleFrom(
                                          primary: CustomColors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          minimumSize: Size(220,
                                              40), // set minimum height and width
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            leading: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffC4C4C4).withOpacity(0.5),
                              ),
                              child: Icon(Icons.logout),
                            ),
                            title: Text("Logout"),
                          ),
                          SizedBox(
                            height: 82,
                          )
                        ],
                      ),
                    );
                  });
            }));
  }
}
