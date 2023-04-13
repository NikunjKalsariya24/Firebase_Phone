import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_string.dart';

class CustomText extends StatelessWidget {


  String? name;
 double? fontSize;
  FontWeight? fontWeight;
  CustomText({this.name,this.fontSize,this.fontWeight,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        name??"" ,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
