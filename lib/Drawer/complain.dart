import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
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
  File? imageFile;

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

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
                    onPressed: () async {
                      _getFromCamera();
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      _getFromGallery();
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

  Widget build(BuildContext context) {
    TextEditingController complaint_title = TextEditingController();
    TextEditingController Phone_no = TextEditingController();
    TextEditingController complaint_description = TextEditingController();
    String datetime = (DateFormat.Md('en_US').add_jm().format(DateTime.now()));
    String imageurl =
        "https://firebasestorage.googleapis.com/v0/b/my-village-7348c.appspot.com/o/Complain%2Fcomplain.png?alt=media&token=2d178ce6-a48f-4f34-8208-493b8b657cdb";

    void add_data() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String title = complaint_title.text.trim();
      String description = complaint_description.text.trim();
      String Phone = Phone_no.text.trim();

      complaint_description.clear();
      complaint_title.clear();
      Phone_no.clear();

      firestore.collection('Complain').doc(title).set({
        "email": user!.email,
        "Phoneno": Phone,
        "title": title,
        "photo": imageurl,
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

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left:0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueGrey,
                            style: BorderStyle.solid,
                            width: 2),
                        borderRadius: (BorderRadius.circular(20))),
                    height: 200,
                    width: 250,
                    child: imageFile != null
                        ?  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image:  FileImage(imageFile!),fit: BoxFit.cover,),
                        borderRadius: (BorderRadius.circular(18)
                        ),
                      ),
                    )
                        :  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image:  NetworkImage(imageurl),fit: BoxFit.cover,),
                        borderRadius: (BorderRadius.circular(18)
                        ),
                      ),
                    )
                  ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 210,top: 160),
                      onPressed: imagePickerOption,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.black,
                          size: 30,

                      ),
                    ),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  width: 350,
                  // height: 300,
                  child: TextFormField(
                    controller: complaint_title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Required';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(Icons.info),
                        labelText: "Complain Title",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                ),
              ),
              SizedBox(height: 4,),
              SizedBox(
                // height: 200,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextFormField(
                    minLines: 2, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: complaint_description,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Required';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(Icons.comment),
                        labelText: "Enter Your Concern Here !!!",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                ),
              ),
              SizedBox(height: 4,),

              SizedBox(
                // height: 200,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Required';
                      } else if (value.length != 10) {
                        return '*Phone number must be of 10 digits';
                      }
                    },
                    controller: Phone_no,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone number",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w800,
                        )),
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
                    onPressed: () async {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      String im = imageFile.toString();
                      int imm = im.lastIndexOf('/');
                      String imgg = im.substring(imm + 1);
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('Complain')
                          .child(imgg);
                      try {
                        await ref.putFile(imageFile!);
                        imageurl = await ref.getDownloadURL();
                      } catch (error) {
                        print("error in photo");
                      }
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
        ),
      ),
    ));
  }
}
