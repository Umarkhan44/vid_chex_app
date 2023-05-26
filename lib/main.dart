import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vid_chex_app/Screens/Splash_screen.dart';
import 'package:vid_chex_app/Screens/add_house%20/add_new_house.dart';
import 'package:vid_chex_app/Screens/auth_screens/create_account.dart';
import 'package:vid_chex_app/Screens/auth_screens/login_screen.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/botton_nevg.dart';
import 'package:vid_chex_app/Screens/profile/profile_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   GoogleMapController.init;
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//     debugShowCheckedModeBanner: false,
//      home:Splash(),
//     );
//   }
//
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Stripe.publishableKey = 'pk_test_51Mx6gfCEuyKogh2QDKhb7yvDZVWnXG4GIIQ01504HrWN7zm3mNf2eBGsXLIdteaFI5SqjERErACHWycU0bb5Q4Hr00mR4SBXkv';
  // Stripe.instance.applySettings();
  GoogleMapController.init;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => LogInScreen(),
       '/house_detail': (context) => BottomNevigation(initialIndex: 1,),
        // '/bottom_navigation': (context) => BottomNavigationScreen(),
         '/profile': (context) => Profile(),
        
        // '/edit_profile': (context) => EditProfileScreen(),
        // '/setting': (context) => SettingScreen(),
        // add more routes for other screens as needed
      },
    );
  }
}
