import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/CategoryScreen.dart';
import 'package:practice/login.dart';
import 'Drawer/setting.dart';
import 'Drawer/contacts.dart';
import 'Drawer/dashboard.dart';
import 'Drawer/events.dart';
import 'Drawer/uploadphoto.dart';
import 'Drawer/voting.dart';
import 'Drawer/complain.dart';
import 'Drawer/update.dart';
import 'Drawer/drawer.dart';
import 'Drawer/Forget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.contacts) {
      container = ContactPage();
    // } else if (currentPage == DrawerSections.events) {
    //   container = EventsPage();
    // }else if (currentPage == DrawerSections.news) {
    //   container = NewsPage();
    }else if (currentPage == DrawerSections.voting) {
      container = VotingPage();
    }else if (currentPage == DrawerSections.expense) {
      container = CategoryScreen();
    }else if (currentPage == DrawerSections.complain) {
      container = Complain();
    // }else if (currentPage == DrawerSections.update) {
    //   container = UpdatePage(title: '',);
    }else if (currentPage == DrawerSections.setting) {
      container = SettingPage();
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
                  // SizedBox(
                  //   height: 70,
                  // ),
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
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
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Emergency Contact", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          // menuItem(3, "Events", Icons.event,
          //     currentPage == DrawerSections.events ? true : false),
          // menuItem(4, "Latest News", Icons.newspaper,
          //     currentPage == DrawerSections.news ? true : false),
          menuItem(3, "Online Voting", Icons.how_to_vote,
              currentPage == DrawerSections.voting ? true : false),
          menuItem(4, "Village Expense", Icons.money_rounded,
              currentPage == DrawerSections.expense ? true : false),
          menuItem(5, "Online Complain", Icons.headset_mic,
              currentPage == DrawerSections.complain ? true : false),
          // menuItem(8, "Update Details", Icons.update,
          //     currentPage == DrawerSections.update ? true : false),
          menuItem(6, "Settings", Icons.settings,
              currentPage == DrawerSections.setting ? true : false),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance
                .signOut()
                .then((value) {
              Navigator.push(context,  MaterialPageRoute(builder: (context) => MyLogin()),);
            }).catchError((e) {
              print(e);
              });
          }, child: Text("Log Out"))
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
              currentPage = DrawerSections.contacts;
            // } else if (id == 3) {
            //   currentPage = DrawerSections.events;
            // } else if (id == 4) {
            //   currentPage = DrawerSections.news;
            } else if (id == 3) {
              currentPage = DrawerSections.voting;
            } else if (id == 4) {
              currentPage = DrawerSections.expense;
            }else if (id == 5) {
              currentPage = DrawerSections.complain;
            // }else if (id == 8) {
            //   currentPage = DrawerSections.update;
            }else if (id == 6) {
              currentPage = DrawerSections.setting;
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
  contacts,
  events,
  news,
  voting,
  expense,
  complain,
  update,
  setting,
}

