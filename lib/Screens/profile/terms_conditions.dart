import 'package:flutter/material.dart';
import 'package:vid_chex_app/Screens/bottom_bar_screens/botton_nevg.dart';
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

class TermConditions extends StatelessWidget {
  const TermConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: availableWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BottomNevigation(initialIndex: 2),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              TextWidget(
                text: "Terms & Conditions",
                textSize: 23,
                color: Colors.black,
                isTitle: true,
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Help protect your website and its users with clear and fair "
                  "website terms and conditions. These terms and conditions for "
                  "a website set out key issues such as acceptable use, privacy, cookies,"
                  " registration and passwords, intellectual property, links to other sites, "
                  "termination and disclaimers of responsibility. Terms and conditions are used and "
                  "necessary to protect a website owner from liability of a user relying on the information "
                  "or the goods provided from the site then suffering a loss.Help protect your website and its users with clear and fair "
                  "website terms and conditions. These terms and conditions for "
                  "a website set out key issues such as acceptable use, privacy, cookies,"
                  " registration and passwords, intellectual property, links to other sites, "
                  "termination and disclaimers of responsibility. Terms and conditions are used and "
                  "necessary to protect a website owner from liability of a user relying on the information "
                  "or the goods provided from the site then suffering a loss.",
                  style: TextStyle(fontSize: 16),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffECECEC),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: availableWidth,
                height: mediaQuery.size.height * 0.3,
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              TextWidget(
                text: "Last Update on 24 Sept, 2021",
                textSize: 15,
                color: Colors.grey,
              ),
              SizedBox(height: mediaQuery.size.height * 0.02),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffECECEC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: availableWidth,
                  height: mediaQuery.size.height * 0.7,
                  child: SingleChildScrollView(
                    child: Text("Help protect your website and its"
                        " users with clear and fair website terms and conditions."
                        " These terms and conditions for a website set out key issues"
                        " such as acceptable use, privacy, cookies, registration and passwords,"
                        " intellectual property, links to other sites, termination and disclaimers of"
                        " responsibility. Terms and conditions are used and necessary to protect a website"
                        " owner from liability of a user relying on the information or the goods provided from the"
                        " site then suffering a loss.Help protect your website and its users with clear and fair website terms"
                        " and conditions. These terms and conditions for a website set out key issues such as acceptable use, privacy,"
                        " cookies, registration and passwords, intellectual property, links to other sites, termination and disclaimers of responsibility."
                        " Terms and conditions are used and necessary to protect a website owner from liability of a user relying on the information or the goods"
                        " provided from the site then suffering a loss.Help protect your website and its users with clear and fair website terms and conditions. These "
                        "terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links "
                        "to other sites, termination and disclaimers of responsibility. Terms and conditions are used and necessary to protect a website owner from liability of a user"
                        " relying on the information or the goods provided from the site then suffering a loss.Help protect your website and its users with clear and fair website terms and conditions. "
                        "These terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links to other sites, "
                        "termination and disclaimers of responsibility. Terms and conditions are used and necessary to protect a website owner from liability of a user relying on the information or the goods provided from the site then suffering a loss."),
                  )),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
