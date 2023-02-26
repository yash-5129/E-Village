import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/Drawer/update.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  Widget event() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 230,
      width: 170,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assest/diwali.jpg"), fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final number1 = '+919328044613';
    final number2 = '+919714193006';
    final number3 = '+916356637280';
    final number4 = '+919909043696';
    final number5 = '+916354215154';
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
                                      fontSize:20,
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
                                trailing: IconButton(onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => UpdatePage(title: "")
                                      ),
                                  );
                                },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.black,),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/newspaper.jfif"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/news.jpg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/newspaper.jfif"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/news.jpg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ]),
            ),
          ),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/diwali.jpg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/navratri.jpeg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/holi.jpg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assest/dushera.jpg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ]),
            ),
          ),
        ])));
  }
}
