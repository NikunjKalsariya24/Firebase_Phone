// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_authentication/widgets/custom_button.dart';
// import 'package:firebase_authentication/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import '../services/firebase_auth_methods.dart';
//
// class PhoneScreen extends StatefulWidget {
//   static String routeName = '/phone';
//   const PhoneScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PhoneScreen> createState() => _PhoneScreenState();
// }
//
// class _PhoneScreenState extends State<PhoneScreen> {
//   final TextEditingController phoneController = TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     phoneController.dispose();
//   }
//
//   void phoneVer() {
//     FirebaseAuthMethods(FirebaseAuth.instance).phoneSignIn(context, phoneController.text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CustomTextField(
//             controller: phoneController,
//             hintText: 'Enter phone number',
//           ),
//           CustomButton(
//             onTap:phoneVer,
//             text: 'OK',
//           ),
//         ],
//       ),
//     );
//   }
//
//   FirebaseAuthMethods(FirebaseAuth instance) {
//
//
//
//     Future<void> phoneSignIn(
//         BuildContext context,
//         String phoneNumber,
//         ) async {
//       TextEditingController codeController = TextEditingController();
//       if (kIsWeb) {
//         // !!! Works only on web !!!
//         ConfirmationResult result =
//         await _auth.signInWithPhoneNumber(phoneNumber);
//
//         // display Dialog Box To accept OTP
//         showOTPDialog(
//           codeController: codeController,
//           context: context,
//           onPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: result.verificationId,//--------------->firebase auto verify kARE
//               smsCode: codeController.text.trim(),//----------------->controller mAtHI ave
//             );
//
//             await _auth.signInWithCredential(credential);
//             Navigator.of(context).pop(); // Remove the dialog box
//           },
//         );
//       } else {
//         // FOR ANDROID, IOS
//         await _auth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (PhoneAuthCredential credential) async {//--------->Automatic handling of the SMS code....
//             // !!! works only on android !!!
//             await _auth.signInWithCredential(credential);
//           },
//           verificationFailed: (e) {//----------------------------------> Displays a message when verification fails
//             showSnackBar(context, e.message!);
//           },
//           // Displays a dialog box when OTP is sent
//           codeSent: ((String verificationId, int? resendToken) async {
//             showOTPDialog(
//               codeController: codeController,
//               context: context,
//               onPressed: () async {
//                 PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                   verificationId: verificationId,
//                   smsCode: codeController.text.trim(),
//                 );
//
//                 // !!! Works only on Android, iOS !!!
//                 await _auth.signInWithCredential(credential);
//                 Navigator.of(context).pop(); // Remove the dialog box
//               },
//             );
//           }),
//           codeAutoRetrievalTimeout: (String verificationId) {
//             // Auto-resolution timed out...
//           },
//         );
//       }
//     }
//   }
// }