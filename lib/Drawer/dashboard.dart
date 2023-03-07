import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/Drawer/events.dart';
import 'news.dart';
import 'package:practice/Drawer/news.dart';
import 'package:practice/Drawer/setting.dart';
import 'package:practice/Drawer/update.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:practice/secretory/Drawer/Eventform.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  int _index = 0;
  int _dataLength = 1;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getimgfromFirebase() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _fireStore.collection('News').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      geteventfromFirebase() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _fireStore.collection('events').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    final currentuser = FirebaseAuth.instance;

    return Scaffold(
        // backgroundColor: Colors.grey.shade200,
        drawer: Drawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              child: Center(
                child: StreamBuilder(
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
                              return ListTile(
                                title: Text(
                                  data['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                  data['phone'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.network(
                                      data['userimage'],
                                      fit: BoxFit.cover,
                                      height: 55,
                                      width: 55,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePage(title: "")),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              height: height * 0.14,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Latest News",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: getimgfromFirebase(),
                builder: (_,
                    AsyncSnapshot<
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                        snapShot) {
                  return CarouselSlider.builder(
                    itemBuilder: (BuildContext context, index, int) {
                      DocumentSnapshot<Map<String, dynamic>> simg =
                          snapShot.data![index];
                      return InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage(simg))),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(simg['photo']),
                                  fit: BoxFit.fitWidth)),
                        ),
                      );
                    },
                    itemCount: snapShot.data!.length,
                    options: CarouselOptions(
                        height: 220,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 0.99,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, caraouselpageChangedReason) {}),

                    //slideTransform: ,
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Events",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: geteventfromFirebase(),
                builder: (_,
                    AsyncSnapshot<
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                        snapShot) {
                  return CarouselSlider.builder(
                    itemBuilder: (BuildContext context, index, int) {
                      DocumentSnapshot<Map<String, dynamic>> simgg =
                          snapShot.data![index];
                      return InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(simgg),)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(simgg['photo']),
                                  fit: BoxFit.fitWidth)),
                        ),
                      );
                    },
                    itemCount: snapShot.data!.length,
                    options: CarouselOptions(
                        height: 220,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 0.99,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, caraouselpageChangedReason) {}),

                    //slideTransform: ,
                  );
                },
              ))
        ])));
  }
}









//
// class DashboardPage extends StatefulWidget {
//   const DashboardPage({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardPage> createState() => _DashboardPage();
// }
//
// class _DashboardPage extends State<DashboardPage> {
//   List<String> _carouselImages = [];
//   List<String> _carouselEvents = [];
//
//   fetchCarouselImages() async {
//     var _firestoreInstance = FirebaseFirestore.instance;
//     QuerySnapshot qn = await _firestoreInstance.collection("News").get();
//     setState(() {
//       for (int i = 0; i < qn.docs.length; i++) {
//         _carouselImages.add(
//           qn.docs[i]["photo"],
//         );
//         print(qn.docs[i]["photo"]);
//       }
//     });
//     return qn.docs;
//   }
//
//   fetchCarouselEvents() async {
//     var _firestoreInstance = FirebaseFirestore.instance;
//     QuerySnapshot qn = await _firestoreInstance.collection("events").get();
//     setState(() {
//       for (int i = 0; i < qn.docs.length; i++) {
//         _carouselEvents.add(
//           qn.docs[i]["photo"],
//         );
//         print(qn.docs[i]["photo"]);
//       }
//     });
//     return qn.docs;
//   }
//
//   @override
//   void initState() {
//     fetchCarouselImages();
//     fetchCarouselEvents();
//     super.initState();
//   }
//   Widget build(BuildContext context) {
//
//
//     final height = MediaQuery.of(context).size.height;
//     final currentuser = FirebaseAuth.instance;
//
//     return Scaffold(
//         // backgroundColor: Colors.grey.shade200,
//         drawer: Drawer(),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           Container(
//               child: Center(
//                 child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("village")
//                         .where("uid", isEqualTo: currentuser.currentUser!.uid)
//                         .snapshots(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                             itemCount: snapshot.data!.docs.length,
//                             shrinkWrap: true,
//                             itemBuilder: (context, i) {
//                               var data = snapshot.data!.docs[i];
//                               return ListTile(
//                                 title: Text(
//                                   data['name'],
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                                 subtitle: Text(
//                                   data['phone'],
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                                 leading: CircleAvatar(
//                                   radius: 40,
//                                   backgroundColor: Colors.white,
//                                   child: ClipOval(
//                                     child: Image.network(
//                                       data['userimage'],
//                                       fit: BoxFit.cover,
//                                       height: 55,
//                                       width: 55,
//                                     ),
//                                   ),
//                                 ),
//                                 trailing: IconButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               UpdatePage(title: "")),
//                                     );
//                                   },
//                                   icon: Icon(
//                                     Icons.edit,
//                                     size: 30,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               );
//                             });
//                       } else {
//                         return CircularProgressIndicator();
//                       }
//                     }),
//               ),
//               height: height * 0.14,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(50),
//                 ),
//               )),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Latest News",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SingleChildScrollView(
//                 child:
//                     CarouselSlider(
//                         items: _carouselImages
//                             .map((item) => InkWell(
//                           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage(),)),
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                                 image: DecorationImage(
//                                     image: NetworkImage(item),
//                                     fit: BoxFit.fitWidth)),
//                           ),
//                         ))
//                             .toList(),
//                         options: CarouselOptions(
//                           height: 220,
//                             autoPlay: true,
//                             enlargeCenterPage: false,
//                             viewportFraction: 0.99,
//                             enlargeStrategy: CenterPageEnlargeStrategy.height,
//                             onPageChanged: (val, caraouselpageChangedReason){}
//                         ),
//                 ),
//                 ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
//             child: Row(
//               children: [
//                 Text(
//                   "Events",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: SingleChildScrollView(
//                   child:
//                   CarouselSlider(
//                     items: _carouselEvents
//                         .map((item) => InkWell(
//                       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage(),)),
//                       child: Container(
//                         margin: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             image: DecorationImage(
//                                 image: NetworkImage(item),
//                                 fit: BoxFit.fitWidth)),
//                       ),
//                     ))
//                         .toList(),
//                     options: CarouselOptions(
//                         height: 220,
//                         autoPlay: false,
//                         enlargeCenterPage: false,
//                         viewportFraction: 0.99,
//                         enlargeStrategy: CenterPageEnlargeStrategy.height,
//                         onPageChanged: (val, caraouselpageChangedReason){}
//                     ),
//                   ),
//                 ),
//               ),
//         ])));
//   }
// }
