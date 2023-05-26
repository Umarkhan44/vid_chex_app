//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'package:intl/intl.dart';
// import 'package:vid_chex_app/Screens/chat/chat_screen.dart';
// import 'package:vid_chex_app/Screens/map_screen/map_screen.dart';
// import 'package:vid_chex_app/conts/Color.dart';
//
// class ChatPage extends StatefulWidget {
//   var userId;
//   var houseid;
//   var userImg;
//   var firstName;
//   var biderImg;
//   var biderName;
//   var proid;
//
//   ChatPage({
//     this.userId,
//     this.houseid,
//     this.userImg,
//     this.firstName,
//     this.biderImg,
//     this.biderName,
//     this.proid,
//   });
//
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final TextEditingController _textEditingController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//
//   String getChatRoomId(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }
//
//   String otherUserUid = ""; // Initialize the other user's UID
//
//   @override
//   void initState() {
//     super.initState();
//     otherUserUid = widget.proid;
//   }
//
//   void _pickImageFromGallery() async {
//     final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       final File imageFile = File(pickedImage.path);
//
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Dialog(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 20),
//                   Text("Uploading image..."),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//
//       try {
//         // Upload the image to Firebase Storage
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('images/${DateTime.now().millisecondsSinceEpoch}');
//         final uploadTask = storageRef.putFile(imageFile);
//
//         uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//           double progress = snapshot.bytesTransferred / snapshot.totalBytes;
//           print('Upload progress: $progress');
//           // Update the progress indicator here if needed
//         });
//
//         final snapshot = await uploadTask.whenComplete(() {});
//         final imageUrl = await snapshot.ref.getDownloadURL();
//
//         // Create a chat message with the image
//         final message = {
//           'uid': FirebaseAuth.instance.currentUser!.uid,
//           'message': imageUrl,
//           'sender': FirebaseAuth.instance.currentUser!.uid,
//           'timestamp': FieldValue.serverTimestamp(),
//           'receiver id': widget.proid,
//           'isImage': true, // Add a flag to indicate that it's an image message
//         };
//
//         // Add the message to Firestore
//         await _db
//             .collection('chats')
//             .doc(getChatRoomId(FirebaseAuth.instance.currentUser!.uid, otherUserUid))
//             .collection('messages')
//             .add(message);
//
//         // Scroll to the bottom of the chat
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//
//         Navigator.pop(context); // Close the progress dialog
//       } catch (e) {
//         // Handle any errors during the upload process
//         print('Error uploading image: $e');
//         Navigator.pop(context); // Close the progress dialog
//       }
//     }
//   }
//
//
//   void _pickImageFromCamera() async {
//     final pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       // Upload the image to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('images/${DateTime.now().millisecondsSinceEpoch}');
//       final uploadTask = storageRef.putFile(File(pickedImage.path));
//       final snapshot = await uploadTask.whenComplete(() {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//
//       // Create a chat message with the image
//       final message = {
//         'uid': FirebaseAuth.instance.currentUser!.uid,
//         'message': imageUrl,
//         'sender': FirebaseAuth.instance.currentUser!.uid,
//         'timestamp': FieldValue.serverTimestamp(),
//         'receiver id': FirebaseAuth.instance.currentUser!.uid,
//         'isImage': true, // Add a flag to indicate that it's an image message
//       };
//
//       // Add the message to Firestore
//       await _db
//           .collection('chats')
//           .doc(getChatRoomId(
//           FirebaseAuth.instance.currentUser!.uid, otherUserUid))
//           .collection('messages')
//           .add(message);
//
//       // Scroll to the bottom of the chat
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
//
//   void _sendMessage() async {
//     if (_textEditingController.text.trim().isNotEmpty) {
//       final message = _textEditingController.text.trim();
//       _textEditingController.clear();
//       await _db
//           .collection('chats')
//           .doc(getChatRoomId(
//           FirebaseAuth.instance.currentUser!.uid, otherUserUid))
//           .collection('messages')
//           .add({
//         'uid': FirebaseAuth.instance.currentUser!.uid,
//         'message': message,
//         'sender': FirebaseAuth.instance.currentUser!.uid,
//         'timestamp': FieldValue.serverTimestamp(),
//         'receiver id': FirebaseAuth.instance.currentUser!.uid,
//         'isImage': false, // Add a flag to indicate that it's a text message
//       });
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size(2, 62),
//         child: AppBar(
//           leadingWidth: 29,
//           backgroundColor: Colors.white,
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(15.0),
//               bottomRight: Radius.circular(15.0),
//             ),
//           ),
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (BuildContext context) => ChatScreen(),
//                 ),
//               );
//             },
//             child: Container(
//               padding: EdgeInsets.only(left: 12),
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           title: ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: CircleAvatar(
//               radius: 23,
//               backgroundImage: NetworkImage(widget.userImg),
//             ),
//             title: Text(
//               widget.firstName,
//               style: TextStyle(color: Colors.black),
//             ),
//             subtitle: Text(
//               'Online',
//               style: TextStyle(color: Colors.green),
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {},
//               child: Text(
//                 "Block",
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _db
//                   .collection('chats')
//                   .doc(getChatRoomId(
//                   FirebaseAuth.instance.currentUser!.uid, otherUserUid))
//                   .collection('messages')
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.green,
//                     ),
//                   );
//                 }
//                 final messages = snapshot.data!.docs.toList();
//                 return ListView.builder(
//                   controller: _scrollController,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index]['message'];
//                     final sender = messages[index]['sender'];
//                     final isImage = messages[index]['isImage'] ?? false;
//
//                     String formatTimestamp(dynamic timestamp) {
//                       if (timestamp == null) {
//                         return '';
//                       }
//
//                       final now = DateTime.now();
//
//                       final dateTime = (timestamp is Timestamp) ? timestamp.toDate() : null;
//
//                       if (dateTime == null) {
//                         return '';
//                       }
//
//                       final difference = now.difference(dateTime);
//
//                       if (difference.inSeconds < 5) {
//                         return 'just now';
//                       } else if (difference.inMinutes < 1) {
//                         return '${difference.inSeconds} seconds ago';
//                       } else if (difference.inHours < 1) {
//                         return '${difference.inMinutes} minutes ago';
//                       } else if (difference.inDays < 1) {
//                         return '${difference.inHours} hours ago';
//                       } else {
//                         final formatter = DateFormat('MMM d, y');
//                         return formatter.format(dateTime);
//                       }
//                     }
//
//                     final msgTime = messages[index]['timestamp'] as Timestamp;
//                     final timeString = formatTimestamp(msgTime);
//
//
//                     if (isImage) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                         child: Align(
//                           alignment: sender ==
//                               FirebaseAuth.instance.currentUser!.uid
//                               ? Alignment.centerRight
//                               : Alignment.centerLeft,
//                           child: Container(
//
//                             decoration: BoxDecoration(
//                               color: CustomColors.green,
//                               borderRadius: BorderRadius.circular(10 ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Container(
//
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       Image.network(
//                                         message,height: 166,fit: BoxFit.cover,
//                                         loadingBuilder: (context, child, loadingProgress) {
//                                           if (loadingProgress == null) return child;
//                                           return Center(
//                                             child: CircularProgressIndicator(
//                                               color: Colors.green,
//                                               value: loadingProgress.expectedTotalBytes != null
//                                                   ? loadingProgress.cumulativeBytesLoaded /
//                                                   loadingProgress.expectedTotalBytes!
//                                                   : null,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                   ],
//                                   ),
//
//                                 ),
//                                 Padding(
//                                   padding:  EdgeInsets.only(right: 8),
//                                   child: Text(
//                                     timeString,style: TextStyle(
//
//                                     fontSize: 13,
//                                       color: Colors.white
//                                   ),textAlign: TextAlign.left,),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                         child: Align(
//                           alignment: sender ==
//                               FirebaseAuth.instance.currentUser!.uid
//                               ? Alignment.centerRight
//                               : Alignment.centerLeft,
//                           child: Container(
//
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: sender == FirebaseAuth.instance.currentUser!.uid
//                                   ? Colors.blue[300]
//                                   : Colors.grey[300],
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Text(
//                               message,
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//
//
//           Container(
//             color: Color(0xfffFFFFFF),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: TextFormField(
//                       controller: _textEditingController,
//                       decoration: InputDecoration(
//                         suffixIcon: InkWell(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Align(
//                                   alignment: Alignment.bottomCenter,
//                                   child: AlertDialog(
//                                     contentPadding: EdgeInsets.only(bottom: 0),
//                                     content: Container(
//                                       height: 90,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               IconButton(
//                                                 onPressed: () {
//                                                   _pickImageFromCamera();
//                                                   Navigator.pop(context);
//                                                   // Handle camera option
//                                                 },
//                                                 icon: Icon(Icons.camera),
//                                               ),
//                                               Text('Camera'),
//                                             ],
//                                           ),
//                                           Column(
//                                             children: [
//                                               IconButton(
//                                                 onPressed: () {
//                                                   _pickImageFromGallery();
//                                                   Navigator.pop(context); // Close the dialog after picking the image
//                                                 },
//                                                 icon: Icon(Icons.photo_library),
//                                               ),
//                                               Text('Gallery'),
//                                             ],
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Icon(Icons.attach_file_sharp),
//                         ),
//
//                         filled: true,
//                         fillColor: Colors.grey.shade200,
//                         hintText: 'Type a message',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade400,
//                             width: 1.0,
//                           ),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       ),
//                     ),
//
//
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       _sendMessage();
//                       // if (_textEditingController.text.trim().isNotEmpty) {
//                       //   final message = _textEditingController.text.trim();
//                       //   _textEditingController.clear();
//                       //   await _db
//                       //       .collection('chats')
//                       //       .doc(getChatRoomId(
//                       //           FirebaseAuth.instance.currentUser!.uid,
//                       //           otherUserUid))
//                       //       .collection('messages')
//                       //       .add({
//                       //     'uid': FirebaseAuth.instance.currentUser!.uid,
//                       //     'message': message,
//                       //     'sender': FirebaseAuth.instance.currentUser!.uid,
//                       //     'timestamp': FieldValue.serverTimestamp(),
//                       //     'receiver id': FirebaseAuth.instance.currentUser!.uid
//                       //   });
//                       //   _scrollController.animateTo(
//                       //     _scrollController.position.maxScrollExtent,
//                       //     duration: Duration(milliseconds: 300),
//                       //     curve: Curves.easeOut,
//                       //   );
//                       // }
//                     },
//                     child: Icon(Icons.send),
//                     style: ElevatedButton.styleFrom(
//                       shape: CircleBorder(),
//                       padding: EdgeInsets.all(16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //   Scaffold(
//
// //   body: Column(
// //     children: [
// //       Expanded(
// //         child: StreamBuilder<QuerySnapshot>(
// //           stream: _firestore.collection('chats')
// //               .where("userId",isEqualTo: widget.userId).snapshots(),
// //           builder: (context, snapshot) {
// //             if (snapshot.hasData) {
// //               final messages = snapshot.data!.docs;
// //               return ListView.builder(
// //                 padding: EdgeInsets.symmetric(vertical: 10),
// //                 itemCount: messages.length,
// //                 itemBuilder: (context, index) {
// //                   final message = messages[index];
// //                   final messageText = message['message'] ?? '';
// //                   final timestamp = message['timestamp'] != null
// //                       ? DateFormat('hh:mm a').format((message['timestamp'] as Timestamp).toDate())
// //                       : '';
// //
// //                   return ChatBubble(
// //                     clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
// //                     alignment: Alignment.topLeft,
// //                     margin: EdgeInsets.only(top: 10),
// //                     backGroundColor: Colors.grey,
// //                     child: Container(
// //                       constraints: BoxConstraints(
// //                         maxWidth: MediaQuery.of(context).size.width * 0.5,
// //                       ),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             messageText,
// //                             style: TextStyle(color: Colors.black, fontSize: 18),
// //                           ),
// //                           Align(
// //                             alignment: Alignment.topRight,
// //                             child: Text(
// //                               timestamp.toString(),
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //
// //                 },
// //               );
// //             } else {
// //               return Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             }
// //           },
// //         ),
// //       ),
// //       Container(
// //         height: 88,
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(25.0),
// //             topRight: Radius.circular(25.0),
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.5),
// //               spreadRadius: 1,
// //               blurRadius: 3,
// //               offset: Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(
// //             horizontal: 8.0,
// //             vertical: 4.0,
// //           ),
// //           child: Row(
// //             children: [
// //               Expanded(
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey.withOpacity(0.1),
// //                     borderRadius: BorderRadius.circular(25.0),
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
// //                     child: TextField(
// //                       controller: messageController,
// //                       decoration: InputDecoration(
// //                         hintText: 'Type your message...',
// //                         border: InputBorder.none,
// //                         suffixIcon: GestureDetector(
// //                           onTap: _openImagePicker,
// //                           child: Icon(
// //                             Icons.file_present_rounded,
// //                             color: Colors.black,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(width: 8.0),
// //               ElevatedButton(
// //                 onPressed: _sendMessage,
// //                 child: Text("Send"),
// //                 style: ElevatedButton.styleFrom(
// //                   minimumSize: Size(26, 26),
// //                   padding: EdgeInsets.all(8.0),
// //                   primary: CustomColors.green,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     ],
// //   )
// //
// // );
//
// // void _sendMessage() {
// //   final String message = messageController.text;
// //   if (message.isNotEmpty) {
// //     // Store the message in Firebase Firestore
// //     _firestore.collection('chats').add({
// //       'message': message,
// //       'timestamp': DateTime.now(),
// //        'userId' :widget.userId
// //     });
// //
// //     // Clear the text field
// //     messageController.clear();
// //   }
// // }
