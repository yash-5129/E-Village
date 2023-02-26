import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../home.dart';
import 'package:intl/intl.dart';

class Complain extends StatefulWidget {
  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  bool isLoading = false;
  bool obsure = true;
  final _formkey = GlobalKey<FormState>();
  @override
  final _firestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  final currentuser = FirebaseAuth.instance;

  final _auth = FirebaseAuth.instance;
  late String name;
  late String address;
  late String email;
  late String pass;
  late String member;
  late String phone;
  File? pickedImage;

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Widget build(BuildContext context) {
    TextEditingController complaint_title = TextEditingController();
    TextEditingController complaint_description = TextEditingController();
    String datetime = (DateFormat.Md('en_US').add_jm().format(DateTime.now()));

    void add_data() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String title = complaint_title.text.trim();
      String description = complaint_description.text.trim();

      complaint_description.clear();
      complaint_title.clear();

      if (title != '' && description != '') {
        firestore.collection('Complain').add({
          "email": user!.email,
          "title": title,
          "Desc": description,
          "time": datetime
        }).then((result) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Complained Successfully"),
            backgroundColor: Colors.blue,
          ));
        }).catchError((onError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(onError),
            backgroundColor: Colors.blue,
          ));
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    height: 200,
                    width: 250,
                    child: Image(
                      image: AssetImage("assest/complain.png"),
                      fit: BoxFit.cover,
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: IconButton(
                      onPressed: imagePickerOption,
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: SizedBox(
                  width: 350,
                  // height: 300,
                  child: TextField(
                    controller: complaint_title,
                    decoration: InputDecoration(
                        labelText: "Complain Title",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(11, 20, 0, 0),
              //       child: Text(
              //         "Write short discription",
              //         textAlign: TextAlign.start,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                // height: 200,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    controller: complaint_description,
                    decoration: InputDecoration(
                        labelText: "Enter Your Concern Here!!!",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
              SizedBox(
                width: 341,
                height: 78,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      add_data();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      "Raise Complain",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
