import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:practice/ExpenseForm.dart';

class SExpense extends StatefulWidget {
  const SExpense({super.key});
  static const name = '/category_screen';
  @override
  State<SExpense> createState() => _SExpenseState();
}

class _SExpenseState extends State<SExpense> {
 // for routes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection("expense").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                   return SlidableAutoCloseBehavior(
                        closeWhenOpened: true,
                        child:ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const BehindMotion(), children: [
                                SlidableAction(
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: "Delete",
                                  onPressed: (context) {
                                      final docuser =FirebaseFirestore.instance.collection('expense').doc(data['title']);
                                      docuser.delete();
                                  },
                                )
                            ],

                            ),
                            child: ListTile(
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
                            ),
                          );
                        }));
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const ExpenseForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void onDismissed(){

  }
}
