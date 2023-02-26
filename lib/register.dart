import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';

class MyRegister extends StatefulWidget {
  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  bool isLoading = false;
  bool obsure = true;
  final _formkey = GlobalKey<FormState>();
  @override
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String datetime = (DateFormat.Md('en_US').add_jm().format(DateTime.now()));
  late String name;
  late String address;
  late String email;
  late String pass;
  late String member;
  late String phone;
  File? imageFile;
  var user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    name = "Flutter Campus";
    super.initState();
  }

  Digest _hashValue(Hash algorithm) {
    var bytes = utf8.encode(pass);
    return algorithm.convert(bytes);
  }

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

  Widget build(BuildContext context) {
    String imageurl ="https://firebasestorage.googleapis.com/v0/b/my-village-7348c.appspot.com/o/userImages%2Fuser.png?alt=media&token=0eb0bbc5-2041-4d3e-acaa-e626665e2c83";
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
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
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'login');
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 20),

                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.indigo, width: 5),
                              borderRadius: const BorderRadius.all(
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
                                      imageurl,
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
                      height: 30,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: _nameController,
                        onChanged: (value) {
                          name = value;
                        },
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
                                    width: 2, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(20.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: "Name",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800,
                            )),
                      ),

                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          address = value;
                        },
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Required field ';
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
                            prefixIcon: Icon(Icons.home_work_outlined),
                            labelText: "Home Address",
                            // onChanged: (value){
                            //   email=value;
                            // },
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          member = value;
                        },
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Required field ';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(20.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: Icon(Icons.family_restroom),
                            labelText: "Family Members",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Required field';
                          } else if (value.length > 10) {
                            return '*Phone number must be of 10 digits';
                          }
                        },
                        onChanged: (value) {
                          phone = value;
                        },
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
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Required field';
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
                            prefixIcon: Icon(Icons.mark_email_unread_outlined),
                            labelText: "Enter Email",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          pass = value;
                        },
                        obscureText: obsure,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Required field';
                          } else if (value.length != 6) {
                            return '*Password must has 6 digits';
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
                            prefixIcon: Icon(Icons.phonelink_lock_outlined),
                            suffixIcon: GestureDetector(
                              child: obsure
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onTap: () {
                                setState(() {
                                  obsure = !obsure;
                                });
                              },
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        // color: Theme.of(context).primaryColor,
                        // textColor: Colors.white,
                        // onPressed: (){Navigator.pushNamed(context, 'home');},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: ()  async {
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }

                          _auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: pass)
                              .then((signedInUser) async {
                            final ref=FirebaseStorage.instance.ref().child('userImages').child(_auth.currentUser!.uid + '.jpg');
                            try{
                              await ref.putFile(imageFile!);
                              imageurl=await ref.getDownloadURL();
                            }catch(error)
                            {
                              print("error in photo");
                            }
                            DocumentReference documentReference =
                                await _firestore
                                    .collection("village")
                                    .doc(email);
                            documentReference.set({

                              'email': email,
                              'name': name,
                              'pass': _hashValue(sha1).toString(),
                              'address': address,
                              "uid": _auth.currentUser!.uid,
                              'member': member,
                              'phone': phone,
                              'userimage': imageurl,
                              'createdAt': datetime,
                            }).then((value) {
                              if (signedInUser != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyLogin()),
                                );
                              }
                            }).catchError((e) {
                              print(e);
                            });
                          }).catchError((e) {
                            print(e);
                          });
                          setState(() {
                            isLoading = true;
                          });

                          // we had used future delayed to stop loading after
                          // 3 seconds and show text "submit" on the screen.
                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          //Navigator.pushNamed(context, 'home');
                        },
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // as elevated button gets clicked we will see text"Loading..."
                                // on the screen with circular progress indicator white in color.
                                //as loading gets stopped "Submit" will be displayed
                                children: const [
                                  // Text('Loading...', style: TextStyle(fontSize: 20),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircularProgressIndicator(
                                      color: Colors.white),
                                ],
                              )
                            : const Text('Create Account'),
                        //child: Text("Create Account"),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 17,
                          ), // TextStyle
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLogin()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ), // Text
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
