import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/secretory/Drawer/Eventform.dart';
import 'package:practice/secretory/Drawer/newsform.dart';
class SEventsPage extends StatefulWidget {
  @override
  State<SEventsPage> createState() => _SEventsPageState();
}
class _SEventsPageState extends State<SEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Slidable(
                              endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: "Delete",
                                    onPressed: (context) {
                                      final docuser = FirebaseFirestore
                                          .instance
                                          .collection('events')
                                          .doc(snapshot.data!.docs[i]
                                      ['event']);
                                      docuser.delete();
                                    },
                                  )
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Image(
                                        image: NetworkImage(snapshot
                                            .data!.docs[i]['photo']),
                                        fit: BoxFit.cover,
                                        height: 55,
                                        width: 55,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "❖ Event " ,
                                        // snapshot.data!.docs[i]['event'],
                                    style: GoogleFonts.alike(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                  subtitle: Text("→ "+
                                        snapshot.data!.docs[i]['event'],
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
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 100,
                                                            bottom: 10),
                                                        child: ClipOval(
                                                            child:
                                                            FullScreenWidget(
                                                              child: Image(
                                                                image: NetworkImage(
                                                                    snapshot.data!
                                                                        .docs[i]
                                                                    ['photo']),
                                                                width: 100,
                                                                height: 100,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            )),
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          "➱ Event : " +
                                                              snapshot.data!
                                                                  .docs[i]
                                                              ['event'],
                                                          style:
                                                          GoogleFonts.alike(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800),
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
                                                          "➱ Description: " +
                                                              snapshot.data!
                                                                  .docs[i]
                                                              ['Description'],
                                                          style:
                                                          GoogleFonts.alike(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800),
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
                                                        "➱ Time: " +
                                                            snapshot.data!
                                                                .docs[i]
                                                            ['time'],
                                                        style:
                                                        GoogleFonts.alike(
                                                          textStyle: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.grey
                                                                  .shade800),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                      ),
                                                    ])));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Eventform(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

