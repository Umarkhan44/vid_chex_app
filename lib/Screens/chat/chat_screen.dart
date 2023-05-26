import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/chat/chat_page.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import 'check.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Row(
              children: [
                Image.asset("assets/dararicon.png"),
                SizedBox(width: 12,),
                TextWidget(text: "Chat", color: CustomColors.green, textSize: 24,isTitle: true,)
              ],
            ),
          ),
          SizedBox(height: 13,),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(width: 2.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    //  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Column(
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.push (
                          context,
                          MaterialPageRoute (
                            builder: (BuildContext context) => ChatPage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage('assets/chatimage.png'),
                        ),
                        title: Text(
                          'User Name',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Message text',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(text: "12:09 PM", color: Colors.grey, textSize: 12),
                            SizedBox(
                              height: 4,
                            ),
                            ClipOval(
                              child: Container(
                                color: Colors.red,
                                height: 22,
                                width: 22,
                                child: Center(
                                  child: Text(
                                    "01",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ));
              },
              itemCount: 7, // replace with actual message count
            ),
          ),
        ],
      ),
    );
  }
}
