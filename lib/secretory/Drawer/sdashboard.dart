import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/Drawer/update.dart';
import 'package:practice/ExpenseForm.dart';
import 'package:practice/secretory/Drawer/userdetails.dart';

class SDashboardPage extends StatefulWidget {
  const SDashboardPage({Key? key}) : super(key: key);

  @override
  State<SDashboardPage> createState() => _SDashboardPage();
}

class _SDashboardPage extends State<SDashboardPage> {
  @override
  Widget build(ContextAction) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('village').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return SingleChildScrollView(
                      // child: Container(
                      //   width: 200,
                      //   height: 100,
                      //   color: Colors.green.shade200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          children: [
                            Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.network(
                                      snapshot.data!.docs[i]['userimage'],
                                      fit: BoxFit.cover,
                                      height: 55,
                                      width: 55,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Name: " + snapshot.data!.docs[i]['name'],
                                  style: GoogleFonts.alike(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800),
                                  ),
                                ),
                                subtitle: Text(
                                  "Email: " + snapshot.data!.docs[i]['email'],
                                  style: GoogleFonts.alike(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800),
                                  ),
                                ),
                                trailing: Icon(Icons.more_vert),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          padding: EdgeInsets.all(20.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 100,
                                                            bottom: 10),
                                                    child: ClipOval(
                                                        child: Image(
                                                      image: NetworkImage(
                                                          snapshot.data!.docs[i]['userimage']),
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

                                                  Text("➱ Name: " + snapshot.data!.docs[i]['name'],
                                                      style: GoogleFonts.alike(
                                                        textStyle: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .grey.shade800),
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
                                                  Text("➱ Email: "+snapshot.data!.docs[i]['email'],
                                                      style: GoogleFonts.alike(
                                                        textStyle: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .grey.shade800),
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
                                                    "➱ Phone: "+snapshot.data!.docs[i]['phone'],
                                                    style: GoogleFonts.alike(
                                                      textStyle: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .grey.shade800),
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
                                                    "➱ Member: "+snapshot.data!.docs[i]['member'],
                                                    style: GoogleFonts.alike(
                                                      textStyle: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .grey.shade800),
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
                                                    "➱ Address: "+snapshot.data!.docs[i]['address'],
                                                    style: GoogleFonts.alike(
                                                      textStyle: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .grey.shade800),
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
                                                    "➱ Created at: "+ snapshot.data!.docs[i]['createdAt'],
                                                    style: GoogleFonts.alike(
                                                      textStyle: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .grey.shade800),
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
                                                ]),
                                          ));
                                    },

                                    // builder: (_) => const Userdetails(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          }
        )
      )
    );
  }
}
