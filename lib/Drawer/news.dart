import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
var simg;
NewsPage(this.simg);
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          // Padding(padding: const EdgeInsets.only(top: 200)),
          // SizedBox(height: 10,)
          SizedBox(
              width: double.infinity,
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('News').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: EdgeInsets.only(top: 65),
                              height: 250,
                              width: 500,
                              child: Image(
                                image: NetworkImage(widget.simg['photo']
                                    ),
                                width: 250,
                                height: 500,
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),

          buttonArrow(context),
          scroll(),
        ],
      )),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.transparent,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 00, sigmaY: 00),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            margin: EdgeInsets.only(top: 25),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.simg['Headlines'],
                          style: GoogleFonts.alike(
                            fontSize: 35,
                          )),
                      // ElevatedButton(
                      //   child: Text("Documents"),
                      //   onPressed: () {},
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      widget.simg['Description'], style: GoogleFonts.alike(
                          fontSize: 15, color: Colors.grey.shade700)),
                ],
              ),
            ),
          );
        });
  }
}
