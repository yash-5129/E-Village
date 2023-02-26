import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/CategoryScreen.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;
  String datetime = (DateFormat.Md('en_US').add_jm().format(DateTime.now()));
  String _initialValue = 'Other';

  void add_data() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String title = _title.text.trim();
    int amount = int.parse(_amount.text);

    _amount.clear();
    _title.clear();

    if (title != '' && amount != '') {
      firestore.collection('expense').doc(title).set({
        "title": title,
        "amount": amount,
        "date": datetime
      }).then((result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Add Expense Successfully"),
          backgroundColor: Colors.blue,
        ));
      }).catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onError),
          backgroundColor: Colors.blue,
        ));
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // title
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Title of expense',
              ),
            ),
            const SizedBox(height: 20.0),
            // amount
            TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount of expense',
              ),
            ),
            const SizedBox(height: 20.0),

            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                add_data();

               Navigator.pop(context);

              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}