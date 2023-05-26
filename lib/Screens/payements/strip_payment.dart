import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:vid_chex_app/widgets/back_button.dart';
import 'package:vid_chex_app/widgets/button_text.dart';

class StripePayments extends StatefulWidget {
  final  price;
  final  uuid;
  final  houseid;
  final  userId;
  final  text;
  const StripePayments({Key? key,
    this.price,
    this.uuid,
    this.houseid,
    this.userId,
    this.text,
  }) : super(key: key);

  @override
  State<StripePayments> createState() => _StripePaymentsState();
}

class _StripePaymentsState extends State<StripePayments> {
  Map<String, dynamic>? paymentIntentData;
  bool isPaymentInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          // Centers the title
          title: TextWidget(
            text: 'Pay Money',
            textSize: 22,
            color: Colors.black,
            isTitle: true,
          ),
          leading: CustomBackButton(
            color: Colors.black, size: Size(12, 12),

          )
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 19, right: 19),
          child: Column(

            children: [
              Image.asset('assets/debit-cards.webp'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Price', color: Colors.black, textSize: 14),
                  TextWidget(text: '\$${widget.price}',
                      color: Colors.black,
                      textSize: 14),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'total amount to pay',
                      color: Colors.black,
                      textSize: 14),
                  SizedBox(height: 20,),
                  TextWidget(
                      text: widget.price, color: Colors.black, textSize: 14),
                ],
              ),
              SizedBox(height: 40,),
              SizedBox(
                width: 170,
                height: 40,
                // child: ElevatedButton(
                //   child: Text('Pay Now'),
                //   onPressed: isPaymentInProgress ? null : () => makePayment(),
                //   style: ElevatedButton.styleFrom(
                //      // Increase the width of the button
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0), // Make the corners circular
                //     ),
                //     primary: Color(0xff4930B3),
                //   ),
                // ),
              ),

              if (isPaymentInProgress) CircularProgressIndicator(
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Future<void> makePayment() async {
//   try {
//     paymentIntentData =
//     await createPaymentIntent(widget.price, 'USD'); //json.decode(response.body);
//     // print('Response body==>${response.body.toString()}');
//     await Stripe.instance
//         .initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//             setupIntentClientSecret: '',
//             paymentIntentClientSecret:
//             paymentIntentData!['client_secret'],
//             //applePay: PaymentSheetApplePay.,
//             //googlePay: true,
//             //testEnv: true,
//             customFlow: true,
//             style: ThemeMode.dark,
//             // merchantCountryCode: 'US',
//             merchantDisplayName: 'umar'))
//         .then((value) {});
//
//     ///now finally display payment sheeet
//     displayPaymentSheet();
//   } catch (e, s) {
//     print('Payment exception:$e$s');
//   }
// }






// *this is not working for me
// // displayPaymentSheet() async {
// //   try {
// //     final User? user = FirebaseAuth.instance.currentUser;
// //     final String? userId = user?.uid;
// //
// //     // Check if user has already paid for this house
// //     final QuerySnapshot<Map<String, dynamic>> bidSnapshot =
// //     await FirebaseFirestore.instance
// //         .collection('bids')
// //         .where('userId', isEqualTo: userId)
// //         .where('houseid', isEqualTo: widget.houseid)
// //         .get();
// //
// //     if (bidSnapshot.docs.isNotEmpty) {
// //       final Map<String, dynamic> bidData = bidSnapshot.docs[0].data();
// //       final String paymentStatus = bidData['paymentStatus'];
// //
// //       if (paymentStatus == 'Paid') {
// //         // If payment is already paid, show a message to the user
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("You have already paid for this house.")),
// //         );
// //         return;
// //       }
// //     }
// //
// //     await Stripe.instance.presentPaymentSheet().then((newValue) async {
// //       // Update the bid in Firebase
// //       if (userId != null) {
// //         final DocumentReference bidReference = FirebaseFirestore.instance
// //             .collection('bids')
// //             .doc(bidSnapshot.docs[0].id);
// //
// //         await bidReference.update({
// //           'paymentStatus': 'Paid',
// //           'paymentDate': DateTime.now().toUtc(),
// //         });
// //
// //         // Create a new document in the 'payment' collection for the buyer
// //         final Map<String, dynamic> paymentData = {
// //           'userId': userId,
// //           'houseid': widget.houseid,
// //           'amount': widget.price,
// //           'paymentDate': DateTime.now().toUtc(),
// //           'paymentType': 'Buyer',
// //         };
// //
// //         await FirebaseFirestore.instance
// //             .collection('payment')
// //             .add(paymentData);
// //
// //         ScaffoldMessenger.of(context)
// //             .showSnackBar(const SnackBar(content: Text("Paid successfully.")));
// //
// //         paymentIntentData = null;
// //       }
// //     }).onError((error, stackTrace) {
// //       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
// //     });
// //   } on StripeException catch (e) {
// //     print('Exception/DISPLAYPAYMENTSHEET==> $e');
// //     showDialog(
// //       context: context,
// //       builder: (_) => const AlertDialog(
// //         content: Text("Cancelled "),
// //       ),
// //     );
// //   } catch (e) {
// //     print('$e');
// //   }
// // }
// // displayPaymentSheet() async {
// //   try {
// //     final User? user = FirebaseAuth.instance.currentUser;
// //     final String? userId = user?.uid;
// //
// //     // Do not check if user has already paid for this house
// //
// //     await Stripe.instance.presentPaymentSheet().then((newValue) async {
// //       // Do not update the bid in Firebase
// //
// //       // Create a new document in the 'payment' collection for the buyer
// //       final Map<String, dynamic> paymentData = {
// //         'userId': userId,
// //         'houseid': widget.houseid,
// //         'amount': widget.price,
// //         'paymentDate': DateTime.now().toUtc(),
// //         'paymentType': widget.text,
// //         'PayStatus': 'Paid',
// //       };
// //
// //       await FirebaseFirestore.instance
// //           .collection('payment')
// //           .add(paymentData);
// //
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(const SnackBar(content: Text("Paid successfully.")));
// //
// //       paymentIntentData = null;
// //     }).onError((error, stackTrace) {
// //       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
// //     });
// //   } on StripeException catch (e) {
// //     print('Exception/DISPLAYPAYMENTSHEET==> $e');
// //     showDialog(
// //       context: context,
// //       builder: (_) => const AlertDialog(
// //         content: Text("Cancelled "),
// //       ),
// //     );
// //   } catch (e) {
// //     print('$e');
// //   }
// //
// //   print("ccccccccccccccc${widget.text}");
// // }**********************************************************************

// void displayPaymentSheet() async {
//   try {
//     final User? user = FirebaseAuth.instance.currentUser;
//     final String? userId = user?.uid;
//
//     // Do not check if user has already paid for this house
//
//     // Show the circular progress indicator
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Loading...")));
//
//     await Stripe.instance.presentPaymentSheet().then((newValue) async {
//       // Do not update the bid in Firebase
//
//       // Create a new document in the 'payment' collection for the buyer
//       final Map<String, dynamic> paymentData = {
//         'userId': userId,
//         'houseid': widget.houseid,
//         'amount': widget.price,
//         'paymentDate': DateTime.now().toUtc(),
//         'paymentType': widget.text,
//         'PayStatus': 'Paid',
//       };
//
//       await FirebaseFirestore.instance
//           .collection('payment')
//           .add(paymentData);
//
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Paid successfully.")));
//
//       paymentIntentData = null;
//     }).onError((error, stackTrace) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       if (error is StripeException && error.error == 'amount_too_small') {
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             content: Text("Amount is too small. Please fix it."),
//           ),
//         );
//       }
//     });
//   } on StripeException catch (e) {
//     print('Exception/DISPLAYPAYMENTSHEET==> $e');
//     showDialog(
//       context: context,
//       builder: (_) => const AlertDialog(
//         content: Text("Cancelled "),
//       ),
//     );
//   } catch (e) {
//     print('$e');
//   }
//
//   print("ccccccccccccccc${widget.text}");
// }



//  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(widget.price),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization': 'Bearer ' + 'sk_test_51Mx6gfCEuyKogh2Qp8LyQxTVq67EVmzR5ddHSFId6U4a8jJvgkp6x3uYbDfOCdNgdgYhgvz0dK5tqIbQfdKxWwS900fnvYjhom',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) ;
//     return a.toString();
//   }
}


