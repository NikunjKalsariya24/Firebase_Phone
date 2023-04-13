import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasephone/main.dart';
import 'package:firebasephone/utils/app_colors.dart';
import 'package:firebasephone/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

import 'controller/auth_controller.dart';
import 'firebase_realtime_database.dart';
import 'utils/app_images.dart';
import 'utils/app_string.dart';

class LoginPage extends StatelessWidget {
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Obx(() => authController.isOtpSent.value
                ? _verifyOtpForm()
                : _getOtpForm())
          ],
        ),
      ),
    );
  }

  _verifyOtpForm() {
    List<TextEditingController> otpFieldsController = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ];
    return SafeArea(
        child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              authController.isOtpSent.value = false;
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 16.sp,
              color: AppColors.blackColor,
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        CustomText(
          name: AppString.verification,
          fontSize: 16.sp,
        ),
        SizedBox(
          height: 1.h,
        ),
        CustomText(
          name: AppString.enterOtp,
          fontSize: 12.sp,
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _textFieldOtp(
                    first: true,
                    last: false,
                    controller: otpFieldsController[0]),
                _textFieldOtp(
                    first: false,
                    last: false,
                    controller: otpFieldsController[1]),
                _textFieldOtp(
                    first: false,
                    last: false,
                    controller: otpFieldsController[2]),
                _textFieldOtp(
                    first: false,
                    last: false,
                    controller: otpFieldsController[3]),
                _textFieldOtp(
                    first: false,
                    last: false,
                    controller: otpFieldsController[4]),
                _textFieldOtp(
                    first: false,
                    last: true,
                    controller: otpFieldsController[5]),
              ]),
              Text(
                authController.statusMessage.value,
                style: const TextStyle(
                    color: AppColors.blackColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    authController.otp.value = "";
                    otpFieldsController.forEach((controller) {
                      authController.otp.value += controller.text;
                    });
                    authController.verifyOTP();
                  },
                  child: CustomText(
                    name: AppString.verify,
                  )),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                name: AppString.notGetCode,
                fontSize: 10.sp,
              ),
              SizedBox(
                height: 1.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    Obx(() => authController.resendOTP.value
                        ? authController.resendOtp()
                        : null);
                  },
                  child: CustomText(
                    name: authController.resendOTP.value
                        ? AppString.resendCode
                        : "Wait ${authController.resendAfter}Second",
                    fontSize: 12.sp,
                  )),



            ],
          ),
        )
      ],
    ));
  }

  _getOtpForm() {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 30.h),
          child: CustomText(
            name: AppString.signIn,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10)),
          child: Obx(
            () => TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              onChanged: (valueOfTextField) {
                authController.phoneNo.value = valueOfTextField;
                authController.showPrefix.value =
                    valueOfTextField.length > 0; //
              },
              onSaved: (newValue) => authController.phoneNo.value = newValue!,
              // Phone number send

              validator: (value) => (value!.isEmpty || value!.length < 10)
                  ? "Enter Valid Number"
                  : null,
              decoration: InputDecoration(
                  hintText: AppString.number,
                  labelText: AppString.number,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.blackColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefix: authController.showPrefix.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            '(+91)',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        ElevatedButton(
            onPressed: () {
              final form = _formKey.currentState;
              if (form!.validate()) {
                form.save();
                authController.getOtp();
                print(
                    "++++++++++++++++++++++++++${authController.isOtpSent.value}");
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              // backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: CustomText(
                name: AppString.getOtp,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            )),
        Padding(
          padding: EdgeInsets.all(1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Google LogIn
              GestureDetector(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: SizedBox(
                      height: 10.h,
                      child: Image.asset(ImageAssets.googleLogo))),
              GestureDetector(
                  onTap: () {
                    signInWithFacebook();
                  },
                  child: SizedBox(
                      height: 10.h,
                      child: Image.asset(ImageAssets.facebookLogo))),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
                onTap: () {

                  googleLogin();


                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.60)),
                    child: Text(
                      "Google Log in",
                      style: TextStyle(fontSize: 25),
                    ))),





          ],
        ),



        SizedBox(height: 5.h,),
        ElevatedButton(onPressed: () {


Get.toNamed("firebaseRealtimeDatabase");

        }, child: Text("Firebase Database")),
      ]),
    ));
  }

  _textFieldOtp({bool first = true, last, controller}) {
    var height = (Get.width - 82) / 6;
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: true,
          controller: controller,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              Get.focusScope?.nextFocus();
            }
            if (value.length == 0 && first == false) {
              Get.focusScope?.previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: height / 2, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


  googleLogin() async {
    print("googleLogin method Called");


    GoogleSignIn _googleSignIn=  GoogleSignIn();
    try {
    var result=   await _googleSignIn.signIn();
    print(result);
    } catch (error) {
      print(error);
    }
    // final _googleSignIn = GoogleSignIn();
    // try {
    //   await _googleSignIn();
    // }
    // catch (error)
    // {
    //   print(error);
    //
    //
    // }
    //
    // var result = await _googleSignIn.signIn();
    // print("Result $result");
  }


}
