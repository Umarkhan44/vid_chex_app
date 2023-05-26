import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';
import 'package:video_player/video_player.dart';

import '../bottom_bar_screens/botton_nevg.dart';

class AddNewHouse extends StatefulWidget {
  const AddNewHouse({Key? key}) : super(key: key);

  @override
  State<AddNewHouse> createState() => _AddNewHouseState();
}

class _AddNewHouseState extends State<AddNewHouse> {
  final List<String> _values = ['House', 'Apartment', 'Condo','layyah'];

  final List<String> _categories = ['House', 'Apartment', 'Condo'];
  final _priceTextController = TextEditingController();
  final _roomTextController = TextEditingController();
  final _kitchenTextController = TextEditingController();
  final _locationTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _bathroomTextController = TextEditingController();
  String? _selectedtType;
  String? _selectedCat;

  String _selectedOption = 'Yes';
  VideoPlayerController? _videoController;
  String? _videoPath;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: TextWidget(
          text: "Add new Listing",
          textSize: 23,
          color: Colors.black,
          isTitle: true,
        ),

        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.push (
              context,
              MaterialPageRoute (
                builder: (BuildContext context) =>  BottomNevigation(initialIndex: 1),
              ),
            );
          },child: Icon(Icons.arrow_back_ios,color: Colors.black,),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25,),
              TextWidget(text: "Add Video", color: Colors.black, textSize: 19,isTitle: true,),
              SizedBox(height: 25,),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.14,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          right: 12,
                          left: 12,
                          bottom: 12,
                          child: DottedBorder(
                              dashPattern: const [6.7],
                              borderType: BorderType.RRect,
                              color: Colors.black,
                              radius: const Radius.circular(12),
                              child: Center(
                                child: InkWell(
                                  onTap: (){
                                    selectVideo();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: _videoController != null  ? Container(
                                            width: double.infinity,
                                            child: AspectRatio(
                                              aspectRatio: _videoController!.value.aspectRatio,
                                              child: VideoPlayer(_videoController!),
                                            ),
                                          )
                                              :Image.asset(
                                            "assets/profile.png",
                                            height: 36,
                                            width: double.infinity,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "Upload video",
                                          color: Colors.black,
                                          textSize: 10)
                                    ],
                                  ),
                                ),
                              )),
                        )
                      ],
                    )),
              ),
              // SizedBox(
              //   height: 30,
              //   width: 30,
              //   child: FloatingActionButton(
              //     backgroundColor: CustomColors.green,
              //     onPressed: () {
              //       setState(() {
              //         if (_videoController!.value.isPlaying) {
              //           _videoController!.pause();
              //         } else {
              //           _videoController!.play();
              //         }
              //       });
              //     },
              //     child: Icon(
              //       _videoController != null && _videoController!.value.isPlaying
              //           ? Icons.pause
              //           : Icons.play_arrow,
              //     ),
              //   ),
              // ),

              TextWidget(text: "Details", color: Colors.black, textSize: 19,isTitle: true,),
              SizedBox(
                height: 20,
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: ' type',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText:
                          _selectedtType == null ? 'House' : _selectedtType,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color(0xff000000),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xff000000),
                            ),
                          ),
                          suffixIcon: DropdownButton<String>(
                            value: _selectedtType,
                            items: _values.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedtType = value;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 25,
                              color: Colors.black,
                            ),
                            underline: SizedBox(),
                            elevation: 8,
                            isExpanded: false,
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            selectedItemBuilder: (BuildContext context) {
                              return _values.map<Widget>((String value) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 40,
                                  ),
                                );
                              }).toList();
                            },
                          ),contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(

                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                          labelText: ' Category',
                          labelStyle: TextStyle(
                            fontSize: 10,
                            color: CustomColors.black,
                          ),
                          hintText: _selectedCat == null
                              ? 'Apartment'
                              : _selectedCat,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color(0xff000000),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xff000000),
                            ),
                          ),
                          suffixIcon: DropdownButton<String>(
                            value: _selectedCat,
                            items: _categories.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedCat = value;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 25,
                              color: Colors.black,
                            ),
                            underline: SizedBox(),
                            elevation: 8,
                            isExpanded: false,
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            selectedItemBuilder: (BuildContext context) {
                              return _categories.map<Widget>((String value) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 40,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _priceTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                          labelText: ' Price',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: "\$ 0",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color(0xff000000),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                           controller: _roomTextController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                                labelText: ' Rooms',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10
                                ),
                                hintText: "Enter rooms",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: TextFormField(
                              controller: _kitchenTextController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                                labelText: ' Kitchen',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10
                                ),
                                hintText: "Enter kitchen",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Color(0xff000000),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _bathroomTextController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                                labelText: ' Bathroom',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10
                                ),
                                hintText: "Enter washrooms",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Color(0xff000000),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                labelText: 'Garage',
                                labelStyle: TextStyle(color: Colors.grey),
                                hintText: _selectedOption,
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                suffixIcon: DropdownButton<String>(
                                 // value: _selectedOption,
                                  items: <String>['No', 'Yes'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,

                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption = newValue!;
                                    });
                                  },
                                underline: SizedBox(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 25,
                                    color: Colors.black,
                                  ),),
                              ),
                            ),
                          )
                            ],
                      ),SizedBox(height: 20,),
                      TextFormField(
                        controller: _locationTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                          labelText: ' Location',

                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: "Enter location",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _descriptionTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Enter description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color(0xff000000),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          print(_priceTextController.text);
                          print(_descriptionTextController.text);
                          print(_locationTextController.text);
                          print(_roomTextController.text);
                          checkValues();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff099E80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // 20 is the radius of the circular shape
                          ),
                          minimumSize: Size(240, 49), // set the width and height
                        ),
                        child: Text('Publish'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Image.asset("assets/accept.png"),



                SizedBox(height: 24,),
                TextWidget(
                  text: "Published!",
                  color: CustomColors.green,
                  textSize: 23,
                  isTitle: true,
                ),

              ],
            ),
          ),
        );
      },
    );
  }
  void _showAlertDialogforfial(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.cancel,size: 44,color: Colors.red,),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 46),
                Text(
                  "Publishing failed",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Please must upload video with listing.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,

                  ),
                ),
                SizedBox(height: 28),
                ElevatedButton(
                  child: Text(
                    "Try again",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Code to retry publishing
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future selectVideo() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Select Video From!',
                    style: TextStyle(
                      color: CustomColors.green,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _pickFromgallery();

                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.video_library,
                                  size: 60,
                                  color: CustomColors.green,
                                ),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          _pickFromCamera();
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.videocam,
                                  size: 60,
                                  color: CustomColors.green,
                                ),
                                Text('Camera'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  Future<void> _pickFromgallery() async {
    final pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoPath = pickedFile.path;

      setState(() {
        _videoController = VideoPlayerController.file(File(_videoPath!))
          ..initialize().then((_) {
            _videoController!.pause();
          });
      });
    }
  }

  Future<void> _pickFromCamera() async {
    final pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      _videoPath = pickedFile.path;

      setState(() {
        _videoController = VideoPlayerController.file(File(_videoPath!))
          ..initialize().then((_) {
            _videoController!.play();
          });
      });
    }
  }
  void checkValues() async {
    if (_videoPath == null || _videoPath!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a video");
    } else if (_selectedCat!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a category");
    } else if (_selectedOption.isEmpty) {
      Fluttertoast.showToast(msg: "Please select Garage");
    } else if (_priceTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a price");
    } else if (_roomTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter the number of rooms");
    } else if (_kitchenTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter the number of kitchens");
    } else if (_locationTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a location");
    } else if (_descriptionTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a description");
    } else {
      _addHouse();
    }
  }
  var _uid = Uuid().v1();
  Future<void> _addHouse() async {
    try {
      var _videoUrl;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: CustomColors.green,
            ),
          );
        },
      );
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('hvideo')
          .child(_uid.toString());
      File file = File(_videoPath!);
      UploadTask task = reference.putFile(file);
      await task.whenComplete(() async {
        final downloadUrl = await reference.getDownloadURL();
        setState(() {
          _videoUrl = downloadUrl;
        });
      });

      final price       = _priceTextController.text;
      final description = _descriptionTextController.text;
      final type        = _selectedtType;
      final category    = _selectedCat;
      final room        = _roomTextController.text;
      final kitchen     = _kitchenTextController.text;
      final bathroom    = _bathroomTextController.text;
      final garage      =  _selectedOption;
      final location    =  _locationTextController.text;
      final collection  = FirebaseFirestore.instance.collection('house');
      final document    = collection.doc(_uid);
      await document.set({
        'providedBy'     : FirebaseAuth.instance.currentUser!.uid,
        'houseid':_uid,
        'description' :  description,
       'type' :         type,
       'category' :     category,
        'bathroom':    bathroom,
        'garage'  :    garage,
       'room' :         room,
       'kitchen' :      kitchen,
        'price'  :     price,
        'location':    location,
        'videoUrl':   _videoUrl
      }).then((value) {
        _showAlertDialog(context);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context); // pop the dialog after 2 seconds
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return BottomNevigation(initialIndex: 2,);
          }));
        });
      });
    }
    catch (e) {
      Navigator.pop(context);
      _showAlertDialogforfial(context);
    }

  }

}
