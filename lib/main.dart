import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasephone/internetcheker.dart';

import 'package:flutter/material.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


// import 'package:otp_login_app/views/home.dart';
// import 'package:otp_login_app/views/login.dart';

import 'firebase_realtime_database.dart';
import 'homepage.dart';
import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
         return GetMaterialApp(
            title: 'OTP Login App',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black))),
            getPages: [
              GetPage(name: "/login", page: () => LoginPage()),
              GetPage(name: "/home", page: () => HomePage()),
              GetPage(name: "/myHomePage", page: () => MyHomePage(title: 'abc',)),
              GetPage(name: "/firebaseRealtimeDatabase", page: () => FirebaseRealtimeDatabase()),

            ],
            initialRoute: "/login",
          );
        },
    );
  }
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//
//   );
//   runApp(MaterialApp(
//     home: phoneverify(),
//   ));
// }
//
//
// class phoneverify extends StatefulWidget {
//   const phoneverify({Key? key}) : super(key: key);
//
//   @override
//   State<phoneverify> createState() => _phoneverifyState();
// }
//
// class _phoneverifyState extends State<phoneverify> {
//  TextEditingController phone = TextEditingController();
//   TextEditingController otp = TextEditingController();
//   // String vd="";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(children: [
//         TextField(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           controller: phone,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         ElevatedButton(
//             onPressed: () async {
//
//
//               await FirebaseAuth.instance.verifyPhoneNumber(
//                 phoneNumber: '+91${phone.text}',
//                 verificationCompleted: (PhoneAuthCredential credential) {},
//                 verificationFailed: (FirebaseAuthException e) {},
//                 codeSent: (String verificationId, int? resendToken) {
//
//                   setState(() {
//                     vd=verificationId;
//                   });
//
//
//                 },
//                 codeAutoRetrievalTimeout: (String verificationId) {},
//               );
//
//
//
//
//
//
//             },
//             child: Text(
//               "Send Otp",
//               style: TextStyle(fontSize: 30),
//             )),
//         TextField(
//           controller: otp,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         ElevatedButton(onPressed: () async {
//           FirebaseAuth auth = FirebaseAuth.instance;
//           String smsCode = '${otp.text}';
//
//           // Create a PhoneAuthCredential with the code
//           PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vd, smsCode: smsCode);
//
//           // Sign the user in (or link) with the credential
//           await auth.signInWithCredential(credential);
//
//
//
//         }, child: Text("Log In")),
//       ]),
//     );
//   }
// }
