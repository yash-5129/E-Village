// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class SExpense extends StatefulWidget {
//   const SExpense({super.key});
//   static const name = '/category_screen';
//   @override
//   State<SExpense> createState() => _SExpense();
// }
//
// class _SExpense extends State<SExpense> {
//   final _title = TextEditingController();
//   final _amount = TextEditingController();
//   DateTime? _date;
//   String _initialValue = 'Other';
//
//
//   _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2022),
//         lastDate: DateTime.now());
//
//     if (pickedDate != null) {
//       setState(() {
//         _date = pickedDate;
//       });
//     }
//   }
//  // for routes
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ListTile(
//             title: Text("Festival",style: TextStyle(color: Colors.black),),
//             subtitle: Text("date"),
//             leading: Image(image:AssetImage('assest/img.png'),color: Colors.blue,fit: BoxFit.fill),
//             trailing: Text("₹ 0.0",style: TextStyle(fontSize: 20),),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (_) =>Container(
//               height: MediaQuery.of(context).size.height * 0.7,
//               padding: const EdgeInsets.all(20.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // title
//                     TextField(
//                       controller: _title,
//                       decoration: const InputDecoration(
//                         labelText: 'Title of expense',
//                       ),
//                     ),
//                     const SizedBox(height: 20.0),
//                     // amount
//                     TextField(
//                       controller: _amount,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         labelText: 'Amount of expense',
//                       ),
//                     ),
//                     const SizedBox(height: 20.0),
//                     // date picker
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(_date != null
//                               ? DateFormat('MMMM dd, yyyy').format(_date!)
//                               : 'Select Date'),
//                         ),
//                         IconButton(
//                           onPressed: () => _pickDate(),
//                           icon: const Icon(Icons.calendar_month),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20.0),
//                     ElevatedButton.icon(
//                       onPressed: () {
//
//                       },
//                       icon: const Icon(Icons.add),
//                       label: const Text('Add Expense'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice/ExpenseForm.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen'; // for routes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
              stream:
              FirebaseFirestore.instance.collection("expense").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];
                        return ListTile(

                          title: Text(
                            data['title'],
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(data['date']),
                          leading: Image(
                              image: AssetImage('assest/img.png'),
                              color: Colors.blue,
                              fit: BoxFit.fill),
                          trailing: Text(
                            "₹"+data['amount'].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
