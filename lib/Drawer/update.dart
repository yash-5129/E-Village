import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:practice/login.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';

bool showPassword = false;

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool obsure = true
  ;
  late String email;
  late String path;
  final _formkey = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser;
  final currentuser = FirebaseAuth.instance;
  File? imageFile;
  File? image;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // void upload(
  //   String filepath,
  //   String filename,
  // ) async {
  //   File file = new File(filepath);
  //   try {
  //     await storage.ref('villagers/$filename').putFile(file);
  //   } on firebase_core.FirebaseException catch (e) {
  //     print(e);
  //   }
  // }
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

    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if(croppedImage!=null)
      {
        setState(() {
          imageFile=File(croppedImage.path);
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
                      // final results = await FilePicker.platform.pickFiles(
                      //   allowMultiple: false,
                      //   allowedExtensions: ['png', 'jpg'],
                      //   type: FileType.custom,
                      // );
                      // if (results == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('No file selected.'),
                      //     ), // SnackBar
                      //   );
                      //   return null;
                      // }
                      // path = results.files.single.path!;
                      // final fileName = results.files.single.name;
                      //
                      // // upload(path,fileName);
                      // print(path);
                      // print(fileName);
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

  // pickImage(ImageSource imageType) async {
  //   try {
  //     final photo = await ImagePicker().pickImage(source: imageType);
  //     if (photo == null) return;
  //     final tempImage = File(photo.path);
  //     setState(() {
  //       pickedImage = tempImage;
  //     });
  //
  //     Get.back();
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("village")
                .where("uid", isEqualTo: currentuser.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {

                      var data = snapshot.data!.docs[i];
                      final TextEditingController _nameController =
                          TextEditingController(text: data['name']);
                      final TextEditingController _addController =
                          TextEditingController(text: data['address']);
                      final TextEditingController _memController =
                          TextEditingController(text: data['member']);
                      final TextEditingController _phoneController =
                          TextEditingController(text: data['phone']);
                      String imageurl= data['userimage'];


                      return Form(
                        key: _formkey,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 16, top: 25, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  Text("Edit Details",
                                      style: GoogleFonts.anton(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.indigo, width: 5),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: imageFile != null
                                                ? Image.file(
                                                    imageFile!,
                                                    width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    data['userimage'],
                                                    width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 5,
                                          child: IconButton(
                                            onPressed: imagePickerOption,
                                            icon: const Icon(
                                              Icons.add_a_photo_outlined,
                                              color: Colors.blue,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '*Required field';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          prefixIcon:
                                              Icon(Icons.person_outline),
                                          labelText: "Full Name",
                                          labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w800,
                                          )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      controller: _addController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '*Required field ';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          prefixIcon:
                                              Icon(Icons.home_work_outlined),
                                          labelText: "Home Location",
                                          labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w800,
                                          )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      controller: _memController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '*Required field ';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          prefixIcon:
                                              Icon(Icons.family_restroom),
                                          labelText: "Family members",
                                          labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w800,
                                          )),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      controller: _phoneController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '*Required field ';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          prefixIcon: Icon(Icons.phone),
                                          labelText: "Phone numbers",
                                          labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w800,
                                          )),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          final String name =
                                              _nameController.text;
                                          final String address =
                                              _addController.text;
                                          final String phone =
                                              _phoneController.text;
                                          final String member =
                                              _memController.text;
                                          final ref=FirebaseStorage.instance.ref().child('userImages').child(user!.uid + '.jpg');

                                          if (!_formkey.currentState!
                                              .validate()) {
                                            // if(imageFile==null)
                                            //   {
                                            //       //  showDialog(context: context, builder: builder)
                                            //   }
                                            return;
                                          }
                                          try{
                                            await ref.putFile(imageFile!);
                                            imageurl=await ref.getDownloadURL();
                                          }catch(error)
                                          {
                                            print("error in photo");
                                          }
                                            DocumentReference documentReference =
                                            await FirebaseFirestore.instance
                                                .collection('village')
                                                .doc(user!.email);
                                            documentReference.update({
                                              'name': name,
                                              'address': address,
                                              'member': member,
                                              'phone': phone,
                                              'userimage': imageurl,
                                              // 'imageurl':path,
                                            });
                                            _nameController.text = '';
                                            _addController.text = '';
                                            _phoneController.text = '';
                                            _addController.text = '';
                                            Navigator.pushNamed(
                                                context, 'home');

                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      Color(0xff3957ed)),
                                        ),
                                        child: Text(
                                          "Update Details",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
