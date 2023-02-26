import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../theme_model.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);
  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return SafeArea(
        child: Container(
          color: Color(0xff3957ed),
          height: 170,
          child: ListView(
            children: [
              StreamBuilder(
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
                            return UserAccountsDrawerHeader(
                              accountName: Text(data['name']),
                              accountEmail: Text(data['email']),
                              currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.network(
                                   data['userimage'],
                                    fit: BoxFit.cover,
                                    height: 72,
                                    width: 72,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff3957ed),
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      );
    });
  }
}
