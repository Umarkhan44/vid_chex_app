import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/botton_nevg.dart';
import 'package:vid_chex_app/Screens/profile/profile_screen.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

class EditProfile extends StatefulWidget {
  String firstName;
  String LastName;
  String userImg;
  String about;
  String email;
  String city;
  String country;
  String dateOfBirth;

  EditProfile({
    Key? key,
    required this.firstName,
    required this.LastName,
    required this.userImg,
    required this.about,
    required this.email,
    required this.city,
    required this.country,
    required this.dateOfBirth,

  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

enum Gender { Male, Female }

class _EditProfileState extends State<EditProfile> {
  Gender _gender = Gender.Male;

  late   TextEditingController _countryTextController;
  late TextEditingController _cityTextController  ;
  late  TextEditingController _aboutTextController ;
  late  TextEditingController _firstNameTextController;
  late   TextEditingController _LastNameTextController ;
  late    TextEditingController _emailTextController ;
  late    TextEditingController _dateOfBrithTextController ;
  final _emailFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _abouttFocusNode = FocusNode();
  final _cityNameFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();

  String selectedImagePath = '';
  // final TextEditingController _userImgController = TextEditingController();
  void initState() {
    super.initState();

    // Initialize the text editing controllers with the data passed from the previous screen
    _firstNameTextController = TextEditingController(text: widget.firstName);
    _LastNameTextController=TextEditingController(text:  widget.LastName);
    _aboutTextController=TextEditingController(text: widget.about);
    _emailTextController=TextEditingController(text:widget.email );
    _cityTextController= TextEditingController(text: widget.city);
    _countryTextController=TextEditingController(text:  widget.country);
    _dateOfBrithTextController=TextEditingController(text:  widget.dateOfBirth);

  }
  @override
  void dispose() {
   _aboutTextController.dispose();
   _countryTextController.dispose();
   _cityTextController.dispose();
   _firstNameTextController.dispose();
   _LastNameTextController.dispose();
   _emailTextController.dispose();
   _dateOfBrithTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final profileImageSize = screenHeight * 0.13;

    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {

                        try {
                          Navigator.push (
                            context,
                            MaterialPageRoute (
                              builder: (BuildContext context) =>  BottomNevigation(initialIndex: 0),
                            ),
                          );
                        } catch (e) {
                          print('Error navigating back: $e');
                        }
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),


                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: screenHeight * 0.03,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15),
                    SizedBox(width: screenWidth * 0.1)
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Container(
                  height: profileImageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 48,
                          backgroundImage: selectedImagePath == ''
                              ? NetworkImage(widget.userImg)
                              : Image.file(File(
                            selectedImagePath,
                          )).image,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        left: 80,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              selectImage();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: TextStyle(
                              color: Color(0xff5F5E5E),
                              fontSize: screenHeight * 0.012,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: screenHeight * 0.056,
                            width: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.27),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              focusNode: _firstNameFocusNode,
                              controller: _firstNameTextController,
                              onChanged: (value){
                                // setState(() {
                                //  _firstNameTextController =  TextEditingController(text: value);
                                // });
                              },
                              decoration: InputDecoration(
                                hintText: "Masaryk",
                                hintStyle: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: screenHeight * 0.015,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10
                                     ),
                              ),
                              textDirection: TextDirection.ltr,
                            ),

                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    // Column for Last Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name',
                            style: TextStyle(
                              color: Color(0xff5F5E5E),
                              fontSize: screenHeight * 0.012,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: screenHeight * 0.056,
                            width: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.27),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              focusNode: _lastNameFocusNode,
                              controller: _LastNameTextController,
                              onChanged: (value){
                                // setState(() {
                                //   _lastNameTextController =  TextEditingController(text: value);
                                // });
                              },
                              decoration: InputDecoration(
                                hintText: "Josan",
                                hintStyle: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: screenHeight * 0.015,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 12)
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xff5F5E5E),
                        fontSize: screenHeight * 0.012,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: screenHeight * 0.056,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.27),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        focusNode: _emailFocusNode,
                        controller: _emailTextController,
                        onChanged: (value) {
                          // Check if the widget is currently active or focused before calling getTextAfterCursor()
                          if (_emailFocusNode.hasFocus) {
                            String textAfterCursor = _emailTextController.value.text.substring(_emailTextController.value.selection.end);
                            // Do something with the text after the cursor

                            // Check if the entered email address is valid
                            bool isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
                            if (isValidEmail) {
                              // Email address is valid
                            } else {
                               Fluttertoast.showToast(msg: "Invalid Email");
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: widget.email,
                          hintStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: screenHeight * 0.015,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                        ),
                        textDirection: TextDirection.ltr,
                      ),

                    ),
                  ],
                ),
                Container(
                    height: 62,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          height: 37,
                          child: TextWidget(
                            textSize: 15,
                            text: "Gender",
                            color: Colors.grey,
                            isTitle: true,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 130,
                            child: RadioListTile<Gender>(
                              contentPadding: EdgeInsets.only(left: 23),
                              title: const Text(
                                'Male',
                                maxLines: 1,
                              ),
                              value: Gender.Male,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 130,
                            child: Center(
                              child: RadioListTile<Gender>(
                                contentPadding: EdgeInsets.only(right: 3),
                                title: const Text(
                                  'Female',
                                  maxLines: 1,
                                ),
                                value: Gender.Female,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 9,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of birth',
                      style: TextStyle(
                        color: Color(0xff5F5E5E),
                        fontSize: screenHeight * 0.012,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: screenHeight * 0.056,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.27),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        focusNode: _dateOfBirthFocusNode,
                        controller: _dateOfBrithTextController,
                        onChanged: (value){

                          // setState(() {
                          //   _dateOfBrithTextController =  TextEditingController(text: value);
                          // });
                        },
                        decoration: InputDecoration(
                          hintText: "Jan 16, 2002",
                          hintStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: screenHeight * 0.015,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Column for First Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: TextStyle(
                              color: Color(0xff5F5E5E),
                              fontSize: screenHeight * 0.012,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: screenHeight * 0.056,
                            width: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.27),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              focusNode: _cityNameFocusNode,
                              onChanged: (value){
                                // setState(() {
                                //   _cityTextController =  TextEditingController(text: value);
                                // });
                              },
                              controller: _cityTextController,
                              decoration: InputDecoration(
                                hintText: widget.city,
                                hintStyle: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: screenHeight * 0.015,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    // Column for Last Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country',
                            style: TextStyle(
                              color: Color(0xff5F5E5E),
                              fontSize: screenHeight * 0.012,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: screenHeight * 0.056,
                            width: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.27),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              focusNode: _countryFocusNode,
                              onChanged: (value){
                                // setState(() {
                                //   _countryTextController =  TextEditingController(text: value);
                                // });
                              },
                              controller: _countryTextController,
                              decoration: InputDecoration(

                                hintStyle: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: screenHeight * 0.015,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xff5F5E5E),
                        fontSize: screenHeight * 0.012,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: screenHeight * 0.056,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.27),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        focusNode: _abouttFocusNode,
                        controller: _aboutTextController,
                        onChanged: (value) {
                          if (_abouttFocusNode.hasFocus) {
                            // Check if there is any text selected before getting the text after the cursor
                            if (_aboutTextController.selection.start != -1 && _aboutTextController.selection.end != -1) {
                              String textAfterCursor = _aboutTextController.value.text.substring(_aboutTextController.selection.end);
                              // Do something with the text after the cursor
                            }
                          }
                          // setState(() {
                          //   _aboutTextController = TextEditingController(text: value);
                          // });
                        },
                        decoration: InputDecoration(
                          hintText: widget.about,
                          hintStyle: TextStyle(
                            color: Color(0xff000000),
                            fontSize: screenHeight * 0.012,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 12)
                        ),
                        textDirection: TextDirection.ltr,
                      ),


                    ),
                  ],
                ),
                SizedBox(
                  height: 33,
                ),
                AuthButton(
                    primary: CustomColors.green,
                    fuc: () {
                      UpdateData();
                    },
                    textWidget: TextWidget(
                      color: Colors.white,
                      text: "Save",
                      isTitle: true,
                      textSize: 18,
                    )),
                SizedBox(
                  height: 33,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
  void UpdateData() async {
    try {
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

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final _uid = _auth.currentUser!.uid;
      String? downloadUrl;

      if (selectedImagePath != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(_uid + '.png');
        await ref.putFile(File(selectedImagePath));
        downloadUrl = await ref.getDownloadURL();
      }

      FirebaseFirestore.instance.collection('user').doc(_uid).update({
        'dateOfBirth': _dateOfBrithTextController.text.trim(),
        'firstName': _firstNameTextController.text.trim(),
        'LastName': _LastNameTextController.text.trim(),
        'country': _countryTextController.text.trim(),
        'city': _cityTextController.text.trim(),
        'about': _aboutTextController.text.trim(),
        'email': _emailTextController.text.trim(),
        if (downloadUrl != null) 'userImg': downloadUrl,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update successfully")));
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }



  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
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
                      'Select Image From !',
                      style: TextStyle(
                          color: CustomColors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/profile.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/profile.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  Text('Camera'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
