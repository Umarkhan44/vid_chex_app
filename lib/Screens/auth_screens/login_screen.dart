import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vid_chex_app/Screens/auth_screens/forget_password.dart';
import 'package:vid_chex_app/Screens/auth_screens/sign_up_screen.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/botton_nevg.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/home_screen.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

import '../../widgets/back_button.dart';
import 'create_account.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  final FirebaseAuth  _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        final user = userCredential.user;
        if (user != null) {
          final String userId = user.uid;

          FirebaseFirestore.instance.collection('user').doc(userId).set({
            'userid': userId,
            'firstName': user.displayName,
            'LastName': '',
            'email': user.email,
            'password': '',
            'userImg': '',
            'acctFrom': 'Google',
            'createdOn': Timestamp.now(),
            'dateOfBirth': '',
            'gender': '',
            'country':'',
            'city': '',
            'about':'',
          }).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BottomNevigation(initialIndex: 1);
            }));
          });

          return user;
        }
      }
    } catch (e) {
      print('Sign-in with Google failed: $e');
    }

    return null;
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();

    super.dispose();
  }

  void _submitFormLogin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [


              SizedBox(height: 55,),
              TextWidget(
                text: "Login",
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
              SizedBox(height: 9,),
              Center(
                child: TextWidget(
                  text: "Welcome back!",
                  color: Colors.black,
                  textSize: 19,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Form(
                  key: _formKey,
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
                            contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
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
                          onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
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
                    child:TextFormField(
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
                                      ? Icons.visibility_off
                                      :Icons.visibility ,
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
                          focusNode: _passFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormLogin();
                          }),),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                            },
                            child: Text(
                              " Forget Password?",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                              ),
                            )),
                      ),
                    ],
                  )),
              SizedBox(height: 33,),
              Center(
                child: _isLoading ? CircularProgressIndicator(
                  color: CustomColors.green,
                ) :AuthButton(
                  primary: Color(0xff099E80),
                  fuc: () {
                    loginUser();
                  },
                  textWidget: TextWidget(
                    text: 'Login ',
                    color: Colors.white,
                    isTitle: true,
                    textSize: 22,
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 83,
                      endIndent: 3,
                      color: Color(0xffD1D1D1),
                      thickness: 1,
                    ),
                  ),
                  TextWidget(
                    text: "or",
                    color: Colors.black,
                    textSize: 10,
                    isTitle: false,
                  ),
                  Expanded(
                    child: Divider(
                      indent: 4,
                      endIndent: 83,
                      color: Color(0xffD1D1D1),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // Add your Google button onPressed logic here
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff365194),
                          borderRadius: BorderRadius.circular(22)
                        //shape: BoxShape.circle,
                      ),
                      width: 130.0,
                      height: 37.0,
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[


                          TextWidget(text: "f", color: Colors.white, textSize: 25,isTitle: true,),

                          Text(
                            "Facebook",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),SizedBox(width: 1,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () async{
                      User? user = await _signInWithGoogle();
                      if (user != null) {
                        // Successfully signed in with Google, do something with the user data
                        print('Signed in with Google: ${user.displayName}');
                      } else {
                        // Failed to sign in with Google
                        print('Failed to sign in with Google');
                      }
                      // Add your Google button onPressed logic here
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(22)
                        //shape: BoxShape.circle,
                      ),
                      width: 130.0,
                      height: 37.0,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                             width: 30,
                            child: Image.asset(
                              "assets/ic_google.png",

                            ),
                          ),

                          Text(
                            "Google",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),SizedBox(width: 1,)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 38,),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? | ",
                      style: TextStyle(fontSize: 13, color: Color(0xff979797)),
                      children: [
                        TextSpan(
                            text: "Sign Up",
                            style: TextStyle(fontSize: 14, color: Color(0xff099E80)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                              })
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // void submitLoginform() async {
  //   String email = _emailTextController.text.trim();
  //   String password = _passTextController.text.trim();
  //   _emailTextController.clear();
  //   _passTextController.clear();
  //   try{
  //     if ( email == ""|| password == ""){
  //       print("plz fill all the fields ");
  //     }
  //     else {
  //       UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  //       if(userCredential.user !=null){
  //         Navigator.push(context,CupertinoPageRoute(builder:(context)=>BottomNevigation()
  //         ),
  //         );
  //       }
  //     }
  //   } on FirebaseAuthException catch(ex){
  //     print(ex.code.toString());
  //   }
  // }
  Future<void> loginUser() async {
    if (_emailTextController.text.isEmpty || _passTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter Email and Password");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where("email", isEqualTo: _emailTextController.text)
          .get();

      bool accountFound = false;

      userSnapshot.docs.forEach((doc) async {
        final email = doc['email'];
        final password = doc['password'];
        if (email == _emailTextController.text &&
            password == _passTextController.text) {
          await _auth.signInWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passTextController.text,
          );
          Fluttertoast.showToast(msg: "Login Successful!");
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => BottomNevigation(initialIndex: 1,)),
          );
          accountFound = true;
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Invalid Email or Password");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Invalid Email or Password");
      } else {
        Fluttertoast.showToast(msg: "Login failed. Please try again.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Login failed. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoading = false;
}
