import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vid_chex_app/Screens/map_screen/map_screen.dart';
import 'package:vid_chex_app/conts/Color.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

class AllowLocation extends StatefulWidget {
  const AllowLocation({Key? key}) : super(key: key);

  @override
  State<AllowLocation> createState() => _AllowLocationState();
}

class _AllowLocationState extends State<AllowLocation> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(height: 30,),

              Image.asset("assets/undraw_current_location_re_j130 1.png"),
              SizedBox(
                height: 30,
              ),
              Text.rich(
                TextSpan(
                  text: 'Allow ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '"VidBuy"',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xff099E80),
                      ),
                    ),
                    TextSpan(
                      text: 'to use \n your location',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'This  app will match you  with the    \n closest house for sale based on\n your location!',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff393939),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push (
                    context,
                    MaterialPageRoute (
                      builder: (BuildContext context) =>  Around_Me_1(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff099E80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // 20 is the radius of the circular shape
                  ),
                  minimumSize: Size(240, 49), // set the width and height
                ),
                child: Text('Allow'),
              ),
              SizedBox(
                height: 30,
              ),
              OutlinedButton(
                onPressed: () {
                  // TODO: Add button functionality here
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // 12 is the radius of the circular shape
                  ),
                  minimumSize: Size(240, 49), // set the width and height
                  side: BorderSide(
                    color: Color(0xff099E80),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'Allow while using app',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff099E80),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // 12 is the radius of the circular shape
                  ),
                  minimumSize: Size(240, 49), // set the width and height
                  side: BorderSide(
                    color: Color(0xff099E80),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  "Don't  Allow ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff099E80),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
