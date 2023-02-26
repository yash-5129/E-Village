import 'package:flutter/material.dart';

class SNewsPage extends StatefulWidget {
  @override
  State<SNewsPage> createState() => _SNewsPageState();
}

class _SNewsPageState extends State<SNewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primaryColor: Colors.grey),
        home: Material(

          child: SingleChildScrollView(
            child:Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Container(
                    width: 200,
                    height: 60,
                    child: Image.asset('assest/news2.jpg',
                    fit: BoxFit.fitWidth,)

                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                      },
                      child: Container(
                        width: 350,
                        height: 170,
                        margin: EdgeInsets.fromLTRB(20.0, 45.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(image: AssetImage('assest/news.jpg'),
                              fit: BoxFit.fitWidth,)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
