import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/theme_model.dart';
import 'package:provider/provider.dart';

class SMyHeaderDrawer extends StatefulWidget {
  const SMyHeaderDrawer({Key? key}) : super(key: key);
  @override
  State<SMyHeaderDrawer> createState() => _SMyHeaderDrawerState();
}

class _SMyHeaderDrawerState extends State<SMyHeaderDrawer> {
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
              UserAccountsDrawerHeader(
                             accountName: Text("Secretary"),
                              accountEmail: Text("Admin@gmail.com"),
                              currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assest/user.png',
                                    fit: BoxFit.cover,

                                    width: 90,
                                    height: 90,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff3957ed),
                              ),
                            )
            ],
          ),
        ),
      );
    });
  }
}
