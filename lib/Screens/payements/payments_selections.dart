import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vid_chex_app/Screens/payements/strip_payment.dart';

import '../../conts/Color.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_text.dart';
import 'check.dart';

class PaymentSelections extends StatefulWidget {


  final  price;
  final  uuid;
  final  houseid;
  final  userId;
  final  text;


  PaymentSelections({Key? key,
    this.price,
    this.uuid,
    this.houseid,
    this.userId,
   required this.text,
  }) : super(key: key);

  @override
  _PaymentSelectionsState createState() => _PaymentSelectionsState();
}

class _PaymentSelectionsState extends State<PaymentSelections> {
  int _selectedValue = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.text);
    print(widget.uuid);
    print(widget.userId);
    print(widget.houseid);

    // Initialize state variables here, if necessary.
  }

  @override
  void dispose() {
    // Clean up any resources or listeners here.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build your widget tree here.
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        leading: CustomBackButton(
          color: Colors.black,
          size: Size(1, 1),
        ),
        title: TextWidget(
          textSize: 23,
          text: "My Bid Details",
          color: Colors.black,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 55,
                  width: 330,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff7D7D7D),
                      width: 1,
                    ),
                  ),
                  child: RadioListTile(
                    activeColor: CustomColors.green,
                    secondary: Image.asset(
                      "assets/paypal.png",
                      height: 40,
                      width: 40,
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value! as int;
                        if (value == 2) {
                          // Launch PayPal login page using URL launcher
                          _launchURL('https:www.paypal.com'); // Replace with the actual PayPal login URL
                        }
                      });
                    },
                    title: Text(
                      "PayPal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                Container(
                  height: 55,
                  width: 330,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff7D7D7D),
                      width: 1,
                    ),
                  ),
                  child: RadioListTile(
                    activeColor: CustomColors.green,
                    secondary: Image.asset(
                      "assets/stripe 1.png",
                      height: 40,
                      width: 40,
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: 3,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value! as int;
                        if (value == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StripePayments(
                            price:widget.price,
                              uuid:widget.uuid,
                              houseid:widget.houseid,
                              userId:widget.userId,
                              text:widget.text,
                            )), // Replace with your own Stripe screen
                          );
                        }
                      });
                    },
                    title: Text(
                      "Stripe",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
            Container(
              height: 55,
              width: 330,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff7D7D7D),
                  width: 1,
                ),
              ),
              child: RadioListTile(
                activeColor: CustomColors.green,
                secondary: Image.asset(
                  "assets/google pay.png",
                  height: 40,
                  width: 40,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                value: 4,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value! as int;
                    if (value == 4) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 300,
                          // Add your UI elements for Google Pay here
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Google Pay',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 10,right: 10),  // Reduce gap between leading and title


                                leading: Image.asset(
                                  "assets/Rectangle 4213.png",
                                  height: 60,
                                  width: 60,
                                ),
                                title: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Title 1',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'Time 1',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),

                                        ),

                                        Text(
                                          'Time 2',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Title 2',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Time 2',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12,),
                              Divider(),
                              SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.payment),
                                  Text("Test , Cards always aproves "),
                                  Icon(Icons.arrow_forward_ios),

                                ],

                              ),
                              SizedBox(height: 12,),
                              Divider(),
                              SizedBox(height: 12,),
                              Text("Test , Cards always aproves "),
                            ],
                          ),
                        ),
                      );
                    }
                  });
                },
                title: Text(
                  "Google Pay",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
                SizedBox(
                  height: 29,
                ),
                Container(
                  height: 55,
                  width: 330,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff7D7D7D),
                      width: 1,
                    ),
                  ),
                  child: RadioListTile(
                    activeColor: CustomColors.green,
                    secondary: Image.asset(
                      "assets/apple 2.png",
                      height: 40,
                      width: 40,
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: 5,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value! as int;
                        if (value == 5) {
                          _scaffoldKey.currentState!.showBottomSheet(
                                (context) => Container(
                              height: 300,
                              // Add your UI elements for Stripe here
                            ),
                          );
                        }
                      });
                    },
                    title: Text(
                      "Apple Pay",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }}
  // Function to launch URL using url_launcher package
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
}


