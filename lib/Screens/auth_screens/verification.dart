import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vid_chex_app/Screens/auth_screens/create_account.dart';
import 'package:vid_chex_app/Screens/map_screen/allow_location.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';
import 'package:http/http.dart' as http;
class OtpScreen extends StatefulWidget {
  final String firstName;
  final String LastName;
  final String email;
  final String password;

  const OtpScreen({Key? key,
    required this.firstName,
    required this.LastName,
    required this.email,
    required this.password}) : super(key: key);

// rest of the code

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpTextController = TextEditingController(text: '');
  String savedOTP='';

  @override
  void initState() {
    // TODO: implement initState
    print(widget.firstName);
    print(widget.email);
    sendOtpCode();
    print(widget.LastName);
    print(widget.firstName);
    print(widget.password);
    print(widget.email);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 66),
              child: Image.asset(
                "assets/Two factor authentication-rafiki 1.png",
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 32),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    text: "Verification",
                    color: Colors.black,
                    textSize: 24,
                    isTitle: true,
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    text: "Enter the OTP code sent to your email",
                    color: Colors.grey,
                    textSize: 12,
                  )),
            ),
            SizedBox(height: 60,),
            Container(
              alignment: Alignment.topCenter,
              child: Pinput(
                controller: _otpTextController,
                length: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                pinAnimationType: PinAnimationType.rotation,
                //controller: _pinOTPCodeCotroller,
                defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
                        border:
                            Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            SizedBox(height: 60,),
            Text(
              "Did not receive a code?",
              style:
                  TextStyle(fontSize: 18, color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () {},
              child: Text(
                "R E S E N D",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.green
              ),
            ),),
            SizedBox(height: 40,),
            AuthButton(
                primary: Color(0xff099E80),
                fuc: () {
                  loadValue("otp2");
                  if (_otpTextController.text == ''){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('please fill otp'),),);
                  } else if (_otpTextController.text == savedOTP) {
                    _UploadDataToFirebase();
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Otp can,t be matched'),
                      ),
                    );
                  }
                },
                textWidget: TextWidget(
                  textSize: 18,
                  text: "Done",
                  color: Colors.white,
                )), SizedBox(height: 40,),
          ],

        ),
      ),
    );
  }
  void _UploadDataToFirebase() async {
    showProgressindicator();
    try {
      await _auth.createUserWithEmailAndPassword(
        email    : widget.email.toString().trim(),
        password : widget.password.toString().trim(),

      );
      final User? user = _auth.currentUser;
      final _uid = user!.uid;

      FirebaseFirestore.instance.collection('user').doc(_uid).set({
        'userid'    : _uid,
        'firstName' : widget.firstName,
        'LastName'  : widget.LastName,
        'email'     : widget.email,
        'password'  : widget.password,
        'userImg'   : '',
        'acctFrom'  : 'Email',
        'createdOn'  : Timestamp.now(),
      }).then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (_){
          return CreateAccount();
        }))
      });
      // Navigator.canPop(context) ? Navigator.pop(context) : null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void showProgressindicator(){
    showDialog(
      context: context,
      builder: (context){
        return Center(
          child: CircularProgressIndicator(
            color: CustomColors.green,
          ),
        );
      },
    );
  }

  Future<void> sendOtpCode() async {
    print('khan');
    String otp = generateOTP();
    Map<String, String> body = {
      'to': widget.email,
      'message':"Hey " + "${widget.firstName} ${widget.LastName}" + ", you're almost ready to start enjoying vid chex. Simply Copy this code " + otp + " and paste in your  App for signup completion ",
      'subject':'vid chex'
    };

    final response = await
    http.post(Uri.parse("https://apis.appistaan.com/mailapi/index.php?key=sk286292djd926d"), body: body);

    print(response);

    if (response.statusCode == 200) {

      saveValue('otp2', otp);

      print(otp);
      Fluttertoast.showToast(msg: "Otp send your Email");

    }
  }
  Future<void> saveValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  // Method to load the value from shared preferences
  Future<void> loadValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedOTP = prefs.getString(key)!;
      print(savedOTP);
    });
  }

  String generateOTP() {
    int length = 4; // Length of the OTP
    String characters = '0123456789'; // Characters to use for the OTP
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += characters[Random().nextInt(characters.length)];
    }
    return otp;
  }
}
