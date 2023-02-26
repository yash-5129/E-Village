import 'package:flutter/material.dart';

class SEventsPage extends StatefulWidget {
  @override
  State<SEventsPage> createState() => _SEventsPageState();
}
class _SEventsPageState extends State<SEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
              width: 200,
              height: 60,
              child: Image.asset('assest/event.png')

            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                  },
                  child: Container(
                    width: 370,
                    height: 168,
                    margin: EdgeInsets.fromLTRB(12.0, 45.0, 0.0, 0.0),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: AssetImage('assest/navratri.jpeg'),
                        fit: BoxFit.fitWidth,)
                      ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    },
                  child: Container(
                    width: 370,
                    height: 168,
                    margin: EdgeInsets.fromLTRB(12.0, 45.0, 0.0, 0.0),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: AssetImage('assest/diwali.jpg'),
                          fit: BoxFit.fitWidth,)
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                  },
                  child: Container(
                    width: 370,
                    height: 168,
                    margin: EdgeInsets.fromLTRB(12.0, 45.0, 0.0, 0.0),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: AssetImage('assest/holi.jpg'),
                          fit: BoxFit.fitWidth,)
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {

                  },
                  child: Container(
                    width: 370,
                    height: 168,
                    margin: EdgeInsets.fromLTRB(12.0, 45.0, 0.0, 0.0),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: AssetImage('assest/dushera.jpg'),
                          fit: BoxFit.fitWidth,)
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

