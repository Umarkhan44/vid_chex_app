import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vid_chex_app/Screens/auth_screens/login_screen.dart';
import 'package:vid_chex_app/Screens/auth_screens/verification.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button.dart';

import '../../widgets/button_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _confirmController = TextEditingController();
  final _lastNameFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  var _confirnobscureText = false;

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _lastNameFocusNode.dispose();
    _confirmController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _confirmFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 44,
              ),
              TextWidget(
                text: "Signup",
                color: Colors.black,
                textSize: 30,
                isTitle: true,
              ),
              Center(
                child: Image.asset(
                  "assets/splash.png",
                  height: MediaQuery.of(context).size.height * 0.16,
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Center(
                child: TextWidget(
                  text: "Let’s Get Started!",
                  color: Colors.black,
                  textSize: 19,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.95),
                              hintText: "First Name",
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
                            controller: _firstNameTextController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_lastNameFocusNode),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.95),
                              hintText: "Last Name",
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
                            controller: _lastNameTextController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
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
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                          child: TextFormField(
                              obscureText: _obscureText,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(.9),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.green,
                                    )),
                                hintText: "Enter Password",
                                contentPadding: EdgeInsets.only(left: 15),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
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
                              controller: _passTextController,
                              //focusNode: _passFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {}),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                          child: TextFormField(
                              obscureText: _confirnobscureText,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(.9),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _confirnobscureText =
                                            !_confirnobscureText;
                                      });
                                    },
                                    child: Icon(
                                      _confirnobscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.green,
                                    )),
                                hintText: "Confirm Password",
                                contentPadding: EdgeInsets.only(left: 15),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
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
                              controller: _confirmController,
                              focusNode: _confirmFocusNode,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {}),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Center(
                child: AuthButton(
                  primary: Color(0xff099E80),
                  fuc: () {
                    print("umar");
                    if (_firstNameTextController.text.isEmpty) {
                      Fluttertoast.showToast(msg: " Enter Your First Name");
                    } else if (_lastNameTextController.text.isEmpty) {
                      Fluttertoast.showToast(msg: " Enter Your Last Name");
                    } else if (_emailTextController.text.isEmpty) {
                      Fluttertoast.showToast(msg: " Enter Your email");
                    } else if (_confirmController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: " Enter Your confirm Password");
                    } else if (_passTextController.text.isEmpty) {
                      Fluttertoast.showToast(msg: " Enter Your Password");
                    } else if (_passTextController.text !=
                        _confirmController.text) {
                      Fluttertoast.showToast(
                        backgroundColor: CustomColors.green,
                        msg: "Password does not match",
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => OtpScreen(
                            password: _passTextController.text,
                            email: _emailTextController.text,
                            LastName: _lastNameTextController.text,
                            firstName: _firstNameTextController.text,
                          ),
                        ),
                      );
                    }
                  },
                  textWidget: TextWidget(
                    text: 'Signup ',
                    color: Colors.white,
                    isTitle: true,
                    textSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? | ",
                      style: TextStyle(fontSize: 13, color: Color(0xff979797)),
                      children: [
                        TextSpan(
                            text: "Login",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff099E80)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LogInScreen()));
                              })
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
