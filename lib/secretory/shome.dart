import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/CategoryScreen.dart';
import 'package:practice/secretory/Drawer/SExpense.dart';

import 'package:practice/secretory/Drawer/scomplain.dart';
import 'package:practice/secretory/Drawer/scontacts.dart';
import 'package:practice/secretory/Drawer/sdashboard.dart';
import 'package:practice/secretory/Drawer/sdrawer.dart';
import 'package:practice/secretory/Drawer/sschooldata.dart';
import 'package:practice/secretory/Drawer/update.dart';
import 'package:practice/secretory/secretarylogin.dart';

class SHomePage extends StatefulWidget {
  @override
  _SHomePageState createState() => _SHomePageState();
}

class _SHomePageState extends State<SHomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = SDashboardPage();
    } else if (currentPage == DrawerSections.expense) {
      container = SExpense();
    } else if (currentPage == DrawerSections.complain) {
      container = SComplainPage();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: Color(0xff3957ed),
          title: Text("E-Village",style: GoogleFonts.alike(
          textStyle:
          TextStyle(fontSize: 23),
        ),),
        ),
        body: container,
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SMyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: GNav(
        //     backgroundColor: Color(0xff3957ed),
        //     color: Colors.white,
        //     activeColor: Colors.white,
        //     tabBackgroundColor: Color(0xff3957de),
        //     tabs: const [
        //       GButton(
        //               icon: Icons.home,
        //               text: "Home",
        //              ),
        //       GButton(icon: Icons.currency_rupee, text: "Expense"),
        //       GButton(icon: Icons.how_to_vote, text: "Voting"),
        //       GButton(icon: Icons.settings, text: "Setting"),
        //     ]),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 0,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Villagers", Icons.people_alt_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Expense", Icons.money,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(3, "Online Complain", Icons.headset_mic,
              currentPage == DrawerSections.complain ? true : false),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySecretary()),
                  );
                }).catchError((e) {
                  print(e);
                });
              },
              child: Text("Log Out")),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.expense;
            } else if (id == 3) {
              currentPage = DrawerSections.complain;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  expense,
  complain,

}
