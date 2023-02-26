import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Userdetails extends StatefulWidget {
  const Userdetails({Key? key}) : super(key: key);

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("village")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            var data = snapshot.data!.docs[i];
                            // final docuser =FirebaseFirestore.instance.collection('village').snapshots();
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100, bottom: 10),
                                    child: ClipOval(
                                        child: Image(
                                      image: AssetImage("assest/user.png"),
                                      width: 100,
                                      height: 100,
                                    )),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Created at: ",
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Name: "+data['name'],
                                      style: GoogleFonts.alike(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade800),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Email",
                                      style: GoogleFonts.alike(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade800),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Phone",
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "member",
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Address",
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                ]);
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ));
  }
}
