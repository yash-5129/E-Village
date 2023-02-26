import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:google_fonts/google_fonts.dart';

class SComplainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Complain')
                    .snapshots(),
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
                                          child: Image(image: AssetImage("assest/complain.jpg"),
                                            fit: BoxFit.cover,
                                            height: 55,
                                            width: 55,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        "Name: " +
                                            snapshot.data!.docs[i]['title'],
                                        style: GoogleFonts.alike(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Email: " +
                                            snapshot.data!.docs[i]['email'],
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
                                                            child: FullScreenWidget(
                                                              child: Image(
                                                          image: AssetImage("assest/complain.jpg"),
                                                                // snapshot.data!
                                                                //         .docs[i][
                                                                //     'userimage']),
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
                                                          "➱ Title: " +
                                                              snapshot.data!
                                                                      .docs[i]
                                                                  ['title'],
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
                                                          "➱ Email: " +
                                                              snapshot.data!
                                                                      .docs[i]
                                                                  ['email'],
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
                                                        "➱ description: " +
                                                            snapshot.data!
                                                                    .docs[i]
                                                                ['Desc'],
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
                                ],
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
