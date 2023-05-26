import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/auth_screens/login_screen.dart';
import 'package:vid_chex_app/Screens/auth_screens/verification.dart';
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();

}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailTextController = TextEditingController();
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xffFFFFFF),
        toolbarHeight: 30,
        iconTheme: IconThemeData(
          color: Color(0xff000000), // set your arrow color here
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48,),


          SizedBox(height: 23,),
              TextWidget(
                  text: "Forgot Password",
                  isTitle: true,
                  color: Colors.black,
                  textSize: 18),
              SizedBox(
                height: 18,
              ),
              TextWidget(
                  text: "Enter your email to recover your password ",
                  color: Color(0xff646464), textSize: 13),
              SizedBox(height: 43,),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 9,
                      spreadRadius: 8,
                      color: Colors.grey.withOpacity(0.15),
                    ),
                  ],
                ),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.95),
                    hintText: "Email",

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
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                 // onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
                ),
              ),
              SizedBox(height: 69,),
              Center(
                child: AuthButton(
                  primary: Color(0xff099E80),
                  fuc: () {

                    // Navigator.pushReplacement (
                    //   context,
                    //   MaterialPageRoute (
                    //     builder: (BuildContext context) =>  OtpScreen(),
                    //   ),
                    // );
                  },
                  textWidget: TextWidget(
                    text: 'Send ',
                    color: Colors.white,
                    isTitle: true,
                    textSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
