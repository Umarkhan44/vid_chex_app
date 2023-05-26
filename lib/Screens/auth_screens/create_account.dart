import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/botton_nevg.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/home_screen.dart';

import 'package:vid_chex_app/Screens/map_screen/allow_location.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _countryTextController = TextEditingController();
  final _cityTextController = TextEditingController();
  final _aboutTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _genderOptions = ['Male', 'Female', 'Other'];
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;

  String selectedImagePath = '';
  @override
  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomColors.green, // color of selected date
              onPrimary: Colors.white, // text color of selected date
            ),
            dialogBackgroundColor:
                Colors.grey[300], // background color of dialog
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        print(_selectedDateOfBirth);
        print(_selectedGender);
        _selectedDateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextWidget(
                  text: "Add more details",
                  color: Colors.black,
                  textSize: 24,
                  isTitle: true,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                // width: MediaQuery.of(context).size.width * 0.9,
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
                        radius: 42,
                        backgroundImage: selectedImagePath == ''
                            ? AssetImage("assets/splash.png")
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
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 9,
                              spreadRadius: 8,
                              color: Colors.grey.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 2, right: 0),
                                    hintStyle: TextStyle(
                                      color: Color(0xffAAAAAA),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    fillColor: Colors.white.withOpacity(0.20),
                                    filled: true,
                                    hintText: _selectedDateOfBirth == null
                                        ? 'Date of Birth'
                                        : _selectedDateOfBirth.toString(),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () => _selectDateOfBirth(context),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 9,
                              spreadRadius: 8,
                              color: Colors.grey.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 5),
                                  hintText: _selectedGender == null
                                      ? 'Gender'
                                      : _selectedGender,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            DropdownButton<String>(
                              value: _selectedGender,
                              items: _genderOptions
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              underline: SizedBox(),
                              elevation: 8,
                              isExpanded: false,
                              dropdownColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              selectedItemBuilder: (BuildContext context) {
                                return _genderOptions
                                    .map<Widget>((String value) {
                                  return Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        width: 40,
                                      ));
                                }).toList();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              spreadRadius: 5,
                              color: Colors.grey.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _countryTextController,
                          cursorWidth: 3,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.95),
                            hintText: "Country",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              spreadRadius: 5,
                              color: Colors.grey.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _cityTextController,
                          cursorWidth: 3,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.95),
                            hintText: "City",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 5,
                        color: Colors.grey.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    readOnly: true,
                    cursorWidth: 3,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllowLocation()),
                            );
                          },
                          child: Icon(
                            Icons.my_location_outlined,
                            color: Colors.black,
                          )),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.95),
                      hintText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 5,
                        color: Colors.grey.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _aboutTextController,
                    cursorWidth: 3,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.95),
                      hintText: "About",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,

                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Center(
                child: AuthButton(
                    primary: Color(0xff099E80),
                    fuc: () {
                      checkValues();
                    },
                    textWidget: TextWidget(
                      text: "Create",
                      textSize: 18,
                      color: Colors.white,
                      isTitle: true,
                    )),
              )
            ]),
      ),
    );
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
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(_uid + '.jpg');

        await ref.putFile(File(selectedImagePath));
        String downloadUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('user').doc(_uid).update({
          'dateOfBirth': _selectedDateOfBirth.toString().trim(),
          'gender': _selectedGender.toString().trim(),
          'country': _countryTextController.text.toString().trim(),
          'city':_cityTextController.text.toString().trim(),
          'about':_aboutTextController.text.toString().trim(),
          'userImg': downloadUrl,

        }).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return BottomNevigation(initialIndex: 1,

            );
          }));
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Upload successfully")));

    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void checkValues() {
     if (selectedImagePath.isEmpty) {
       Fluttertoast.showToast(

           msg: "Please Select the image");
     }if(_selectedDateOfBirth==null){
       Fluttertoast.showToast(


           msg: "Please Select the Date of bearth ");
     }if(_selectedGender!.isEmpty)
     {
       Fluttertoast.showToast(


           msg: "Please select the gender");
     }if (_countryTextController.text.isEmpty){
       Fluttertoast.showToast(


           msg: "Please Enter your city ");
     }if(_cityTextController.text.isEmpty)
     {
       Fluttertoast.showToast(


           msg: "Please Enter the city  ") ;
     }if (_aboutTextController.text.isEmpty ){
       Fluttertoast.showToast(


           msg: "Enter your About");
     }else
     {
       UpdateData();
     }


}
}
