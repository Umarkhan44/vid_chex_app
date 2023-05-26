import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/auth_screens/login_screen.dart';

import 'bottom_bar_screens/botton_nevg.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 6),
          ()=>Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context) =>
           FirebaseAuth.instance.currentUser != null
            ?BottomNevigation(initialIndex: 1,)
            : LogInScreen()
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset("assets/splash.png",)),
    );
  }
}
