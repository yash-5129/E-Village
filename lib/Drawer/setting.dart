// import 'package:day_night_switcher/day_night_switcher.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:practice/main.dart';
// import 'package:practice/splash.dart';
// import 'package:practice/theme.dart';
// import 'package:practice/theme_model.dart';
// import 'package:provider/provider.dart';
//
// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);
//
//   @override
//   State<SettingsPage> createState() => _SettingsPage();
// }
//
// class _SettingsPage extends State<SettingsPage> {
//
//   ThemeSharedPreferences themeSharedPreferences = ThemeSharedPreferences();
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context,ThemeModel themeNotifier,child){
//       return SafeArea(
//         child: Scaffold(
//           body: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 100,
//                 ),
//                 // DayNightSwitcherIcon(isDarkModeEnabled: , onStateChanged:),
//                 Text(themeNotifier.isDark ? "Dark Mode" : "Light Mode"),
//                 DayNightSwitcher(
//                     isDarkModeEnabled: themeNotifier.isDark ? true : false,
//                     onStateChanged: (value) {
//                       themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
//                       print(value);
//                       themeSharedPreferences.setTheme(value);
//                       setState(() {
//                       });
//                       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Splash()), (route) => false);
//                     })
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//     );
//   }
// }
//
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice/home.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> _carouselImages = [];
   static String io="";

  fetchCarouselImages() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("News").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["photo"],
        );
        print(qn.docs[i]["photo"]);
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
              items: _carouselImages
                  .map((item) => InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)),
                    child: Container(
                margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth)),
                        ),
                  ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: false,
                viewportFraction: 0.8,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (val, caraouselpageChangedReason){}
              )),
        ],
      ),
    ));
  }
}
