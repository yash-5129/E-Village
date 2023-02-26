import 'package:flutter/material.dart';

class SchoolData extends StatefulWidget {
  const SchoolData({Key? key}) : super(key: key);

  @override
  State<SchoolData> createState() => _SchoolDataState();
}

class _SchoolDataState extends State<SchoolData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 900,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(image: AssetImage('assest/schoolMap.webp'),fit: BoxFit.fill)
              ),
            ),
            Container(
              width: MediaQuery.of (context).size.width,
              height: MediaQuery.of (context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 180,
                          width: 180,
                          color: Colors.red,
                        ),
                        Container(
                          height: 180,
                          width: 180,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
