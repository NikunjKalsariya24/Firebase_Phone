import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FirebaseRealtimeDatabase extends StatefulWidget {
  const FirebaseRealtimeDatabase({Key? key}) : super(key: key);

  @override
  State<FirebaseRealtimeDatabase> createState() =>
      _FirebaseRealtimeDatabaseState();
}

class _FirebaseRealtimeDatabaseState extends State<FirebaseRealtimeDatabase> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final databaseRef =
      FirebaseDatabase.instance.ref(); //create instance for database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(
          "Insert Data",
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextField(
          controller: numberController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  numberController.text.isNotEmpty) {
                insertData(nameController.text, numberController.text);
              }
            },
            child: Text("Insert")),
      ]),
    );
  }

  void insertData(String name, String number) {
    String? key = databaseRef
        .child("user")
        .child("ListRegister")
        .push()
        .key; //for key set
    // databaseRef.child("user").child("ListRegister").child("key").push().set({       //key for use
    databaseRef.child("user").child("ListRegister").push().set({
      'id': key, // refrance key change value
      'name': name, // pass data

      'number': number, // pass data
    });
    nameController.clear();
    numberController.clear();
  }
}
