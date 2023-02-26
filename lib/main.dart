import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/Events/navratri.dart';
import 'package:practice/Drawer/newsdetail.dart';
import 'package:practice/Drawer/Forget.dart';
import 'package:practice/register.dart';
import 'package:practice/theme_model.dart';
import 'Drawer/update.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'Drawer/Forget.dart';
import 'login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp ({Key? key}) : super(key: key);
    final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(_)=>ThemeModel(),
        child : Consumer (builder: (context, ThemeModel themeModal, child){
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
      home:
      AnimatedSplashScreen(splash:
        Image.asset('assest/homelogo.jpg',
          height: 500,
          width: 500,
        ),
        backgroundColor: Colors.black,
        duration: 2500,
        nextScreen:auth.currentUser==null?MyLogin():HomePage(),
        ),

    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => HomePage(),
      'event1':(context) => ED(),
      'news1':(context) => ND(),
      'update' :(context)=>UpdatePage(title: '',),
      'forget' :(context)=>Forget(),

    },
      themeMode:themeModal.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: themeModal.isDark ? Brightness.dark : Brightness.light,
      ),
    );
        }
        )
    );
  }
}