import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';

class NewsForm extends StatefulWidget {
  const NewsForm({Key? key}) : super(key: key);

  @override
  State<NewsForm> createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  final _head = TextEditingController();
  final _desc = TextEditingController();
  String datetime = (DateFormat.Md('en_US').add_jm().format(DateTime.now()));
  String imageurl =
      "https://firebasestorage.googleapis.com/v0/b/my-village-7348c.appspot.com/o/Complain%2Fcomplain.png?alt=media&token=2d178ce6-a48f-4f34-8208-493b8b657cdb";
  String fileurl = "";
  File? imageFile;

  final _formkey = GlobalKey<FormState>();
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;

  void PickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
        print("filename $_fileName");
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Color(0xff3957ed),
        title: Text(
          "E-Village",
          style: GoogleFonts.alike(
            textStyle: TextStyle(fontSize: 23),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueGrey,
                                style: BorderStyle.solid,
                                width: 2),
                            borderRadius: (BorderRadius.circular(20))),
                        height: 200,
                        width: 250,
                        child: imageFile != null
                            ? Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(imageFile!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: (BorderRadius.circular(18)),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageurl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: (BorderRadius.circular(18)),
                                ),
                              )),
                    Positioned(
                      top: 140,
                      right: 20,
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
                  height: 20.0,
                ), // title
                TextFormField(
                  controller: _head,
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
                          borderSide:
                              BorderSide(width: 2, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20.0)),
                      prefixIcon: Icon(Icons.info),
                      labelText: "HeadLines",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      )),
                ),
                const SizedBox(height: 15.0),
                // amount
                TextFormField(
                  controller: _desc,
                  minLines:
                      3, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
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
                          borderSide:
                              BorderSide(width: 2, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20.0)),
                      prefixIcon: Icon(Icons.description),
                      labelText: "Description",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      )),
                ),
                const SizedBox(height: 20.0),
                isLoading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          PickFile();
                        },
                        child: Text('Pick File')),
  // if(pickedfile!=null)
  //            SafeArea(
  //               top: false,
  //               bottom: false,
  //               child: Container(
  //                   padding: const EdgeInsets.only(top: kToolbarHeight),
  //                   child: PspdfkitWidget(
  //                       documentPath: pickedfile!
  //                           .path))),// Container


                const SizedBox(height: 20.0),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    String head = _head.text.trim();
                    String desc = _desc.text.trim();

                    //For File
                    final reff = FirebaseStorage.instance
                        .ref()
                        .child('News')
                        .child(_fileName!);
                    try {
                      await reff.putFile(fileToDisplay!);
                      fileurl = await reff.getDownloadURL();
                    } catch (error) {
                      print("error in file");
                    }

                    // For photo
                    String im = imageFile.toString();
                    int imm = im.lastIndexOf('/');
                    String imgg = im.substring(imm + 1);
                    final ref = FirebaseStorage.instance
                        .ref()
                        .child('News')
                        .child(imgg);
                    try {
                      await ref.putFile(imageFile!);
                      imageurl = await ref.getDownloadURL();
                    } catch (error) {
                      print("error in photo");
                    }

                    firestore.collection('News').doc(head).set({
                      "Headlines": head,
                      "Description": desc,
                      "photo": imageurl,
                      "time": datetime,
                      "Document": fileurl,
                    }).then((result) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Add News Successfully"),
                        backgroundColor: Colors.blue,
                      ));
                    }).catchError((onError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(onError),
                        backgroundColor: Colors.blue,
                      ));
                    });

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add News'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
