import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  @override
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool obsure = true;
  late String opass;
  late String npass;
  var currentUser = FirebaseAuth.instance.currentUser;
  var auth = FirebaseAuth.instance;

  changePassword({email, oldPassword, newPassword}) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password Changed Successfully"),
        backgroundColor: Colors.blue,
      ));
      Navigator.pop(context);
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError),
        backgroundColor: Colors.blue,
      ));
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Icon(
                    Icons.security,
                    color: Theme.of(context).primaryColor,
                    size: 90,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      onChanged: (value) {
                        opass = value;
                      },
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*Required field';
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(20.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(20.0)),
                          prefixIcon: Icon(Icons.phonelink_lock_outlined),
                          suffixIcon: GestureDetector(
                            child: obsure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                obsure = !obsure;
                              });
                            },
                          ),
                          labelText: "Enter Old Password",
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      onChanged: (value) {
                        npass = value;
                      },
                      obscureText: obsure,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*Required field';
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(20.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(20.0)),
                          prefixIcon: Icon(Icons.phonelink_lock_outlined),
                          suffixIcon: GestureDetector(
                            child: obsure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                obsure = !obsure;
                              });
                            },
                          ),
                          labelText: "Enter New Password",
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        }
                        changePassword(
                          email: currentUser!.email,
                          oldPassword: opass,
                          newPassword: npass,
                        );
                        // FirebaseFirestore.instance
                        //     .collection('admin')
                        //     .doc('adminLogin')
                        //     .snapshots()
                        //     .forEach((element) {
                        //   if (element.data()?['adminEmail'] == aemail &&
                        //       element.data()?['adminPass'] == apass) {
                        //     Navigator.pushNamed(context, 'adminpanel');
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         backgroundColor: Colors.lightBlue,
                        //         content: Text(
                        //           "Please enter valid credentials of admin",
                        //           style: TextStyle(
                        //               fontSize: 18.0, color: Colors.black),
                        //         ),
                        //       ),
                        //     );
                        //   }
                        // });

                        setState(() {
                          isLoading = true;
                        });

                        // we had used future delayed to stop loading after
                        // 3 seconds and show text "submit" on the screen.
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // as elevated button gets clicked we will see text"Loading..."
                              // on the screen with circular progress indicator white in color.
                              //as loading gets stopped "Submit" will be displayed
                              children: const [
                                // Text('Loading...', style: TextStyle(fontSize: 20),),
                                SizedBox(
                                  width: 10,
                                ),
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
