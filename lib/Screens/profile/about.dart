import 'package:flutter/material.dart';
import 'package:vid_chex_app/widgets/back_button.dart';


class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: CustomBackButton(
          color: Colors.black,
          size: Size(33,33),
        ),
        title: Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 23,right: 21,top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/splash.png",
                  height: MediaQuery.of(context).size.height * 0.16,
                ),
              ),
              SizedBox(height: 27,),
              Text("Help protect your website and its users with clear and fair website terms and conditions.",maxLines: 2,textAlign: TextAlign.center,),
              SizedBox(height: 27,),
              Text("Version",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 7,),
              Text("2.1.0"),
              SizedBox(height: 17,),
              Text("Powered by",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 7,),
              Text("Park Rights"),
              SizedBox(height: 27,),
              Align(alignment: Alignment.topLeft,
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),)),
              SizedBox(height: 27,),
              Row(
                children: [
                  Icon(Icons.wordpress_outlined,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text("www.parkright.app"),
                ],
              ),
              SizedBox(height: 27,),
              Row(
                children: [
                  Icon(Icons.email_outlined,color: Colors.red,),
                  SizedBox(width: 10,),
                  Text("Info@parkright.app"),
                ],
              ),

              SizedBox(height: 17,),
              Center(child: Image.asset("assets/Group 18477.png"))  ],
          ),
        ),
      ),
    );
  }
}
