import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/inner_screens/house_detail.dart';
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';
import 'package:video_player/video_player.dart';

class SeeAllHouses extends StatefulWidget {
  SeeAllHouses({Key? key}) : super(key: key);

  @override
  State<SeeAllHouses> createState() => _SeeAllHousesState();
}

class _SeeAllHousesState extends State<SeeAllHouses> {

  final user = FirebaseAuth.instance.currentUser;

  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // initialize the video player controller
    _initVideoPlayer();
  }

  void _initVideoPlayer() async {
    final String videoUrl = await FirebaseStorage.instance.ref().child('house').child('videoUrl').getDownloadURL();
    _videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // dispose the video player controller
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          leading: CustomBackButton(color: Colors.black, size: Size.infinite),
          title: TextWidget(
            textSize: 19,
            text: "House",
            color: Colors.black,
            isTitle: true,
          ),
          centerTitle: true,
          actions: [
            Icon(
              Icons.search,
              size: 28,
              color: Color(0xff263238),
            ),
            GestureDetector(
              onTap: () {
                BottomSheetOK(context);
              },
              child: Image.asset("assets/slider_03.png"),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('house')
                        .where('providedBy',
                        isNotEqualTo:
                        user!.uid) // exclude houses added by the current user
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text("No houses found"),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          final house = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () async {
                              final userSnapshot =
                              await FirebaseFirestore.instance.collection('user').doc(house['providedBy']).get();
                              final userData = userSnapshot.data()!;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HouseDetail(
                                    bathroom: house['bathroom'],
                                    category: house['category'],
                                    description: house['description'],
                                    garage: house['garage'],
                                    kitchen: house['kitchen'],
                                    room: house['room'],
                                    type: house['type'],
                                    price: house['price'],
                                    location: house['location'],
                                    videoUrl: house['videoUrl'],
                                    firstName: userData['firstName'],
                                    userImg: userData['userImg'],
                                    about: userData['about'],
                                    houseid: userData['houseid'],
                                    proid: userData['providedBy'],
                                    // AcceptedTime: house['AcceptedTime'],
                                    // timestamp: house['timestamp'],
                                    // Status:house['Status'],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                ListTile(
                            leading: Container(
                            color: Colors.black,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.16,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized)
                                    AspectRatio(
                                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                                      child: VideoPlayer(_videoPlayerController!),
                                    )
                                  else
                                    CircularProgressIndicator(),
                                  GestureDetector(
                                    onTap: () {
                                      if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
                                        if (_videoPlayerController!.value.isPlaying) {
                                          _videoPlayerController!.pause();
                                        } else {
                                          _videoPlayerController!.play();
                                        }
                                      }
                                    },
                                    child: Icon(
                                      _videoPlayerController != null && _videoPlayerController!.value.isInitialized && _videoPlayerController!.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 36,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextWidget(
                                        text: house['type'],

                                        textSize: 16,
                                        color: Colors.black,
                                        isTitle: true,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      TextWidget(
                                        text: house[
                                        'location'], // use house address from Firebase
                                        textSize: 10,
                                        color: Color(0xff828282),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      TextWidget(
                                        text:
                                        '\$ ${house['price']}  ', // use house price from Firebase
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
                            ),
                          );
                        },
                      );
                    },
                  ),

                ])));

  }
}

void BottomSheetOK(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      context: context,
      builder: (BuildContext context) {
        int _selectedRadioButton = 1;
        String _selectedValue = '\$ 50000'; // set an initial value

        List<String> _options = [
          '\$ 50000',
          '\$ 33',
          '\$ 3350000',
          '\$ 908050000',
        ];
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Divider(
                    thickness: 4,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xff7E7E7E),
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Filter by",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.green),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffD8D8D8),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            text: "Location",
                            color: Colors.black,
                            textSize: 15),
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            text: "Price Under",
                            color: Colors.black,
                            textSize: 15),
                        DropdownButton<String>(
                          value: _selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValue = newValue!;
                            });
                          },
                          items: _options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                      ],
                    ),),
                  Divider(
                    thickness: 1,
                    color: Color(0xffD8D8D8),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('New House',
                          style: TextStyle(
                              fontSize: 15,color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Radio<int>(
                          activeColor: Colors.green,
                          value: 1,
                          groupValue: _selectedRadioButton,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRadioButton = value!;
                            });
                          },
                        ),
                      ],
                    ),),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Price high to low',
                          style: TextStyle(
                              fontSize: 15,color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Radio<int>(
                          activeColor: Colors.green,
                          value: 2,
                          groupValue: _selectedRadioButton,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRadioButton = value!;
                            });
                          },
                        ),
                      ],
                    ),),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 5),
                    child:Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Price low to high',
                          style: TextStyle(
                              fontSize: 15,color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),),
                        Radio<int>(
                          activeColor: Colors.green,
                          value: 3,
                          groupValue: _selectedRadioButton,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRadioButton = value!;
                            });
                          },
                        ),
                      ],
                    ),),
                  SizedBox(height: 29,),
                  AuthButton(primary: CustomColors.green, fuc: (){}, textWidget: TextWidget(
                    text: "Apply ",textSize: 18,isTitle: true,color: Colors.white,
                  )),
                  SizedBox(height: 29,)],


              ),
            );
          },
        );
      });
}

