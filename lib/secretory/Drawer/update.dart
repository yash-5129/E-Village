import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/login.dart';

bool showPassword = false;

class SUpdatePage extends StatefulWidget {
  const SUpdatePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SUpdatePage> createState() => _SUpdatePageState();
}

class _SUpdatePageState extends State<SUpdatePage> {
  bool obsure = true;
  late String email;
  final _formkey = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser;
  final currentuser = FirebaseAuth.instance;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                          final TextEditingController _nameController = TextEditingController(text: data['name']);
                          final TextEditingController _addController = TextEditingController(text: data['address']);
                          final TextEditingController _memController = TextEditingController(text: data['member']);
                          final TextEditingController _phoneController = TextEditingController(text: data['phone']);

                          return Form(
                            key: _formkey,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
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
                                                  border: Border.all(color: Colors.indigo, width: 5),
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(100),
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child:pickedImage !=null ? Image.file(pickedImage!,width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover,) :
                                                  Image.network(
                                                    'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
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
                                      prefixIcon: Icon(Icons.person_outline),
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
                                  prefixIcon: Icon(Icons.family_restroom),
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
                          final String name = _nameController.text;
                          final String address = _addController.text;
                          final String phone = _phoneController.text;
                          final String member = _memController.text;

                          if (!_formkey.currentState!
                              .validate()) {
                          return;
                          }
                          DocumentReference documentReference =
                          await FirebaseFirestore.instance
                              .collection('village')
                              .doc(user!.email);
                          documentReference.update({
                          'name': name,
                          'address': address,
                          'member': member,
                          'phone': phone
                          });
                          _nameController.text='';
                          _addController.text='';
                          _phoneController.text='';
                          _addController.text='';
                          Navigator.pushNamed(context, 'home');
                          },
                          style: ButtonStyle(
                          backgroundColor:
                          MaterialStateColor.resolveWith(
                          (states) => Color(0xff3957ed)),
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
                })));
  }
}