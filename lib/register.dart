import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email_password/email_password.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool tpass = true;
  bool tpass1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              children: [

                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.grey.shade100),
                ),
                SizedBox(height: 20),

                TextField(
                  controller: _password,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: tpass,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              tpass = !tpass1;
                            });
                          }, icon: Icon(tpass1?Icons.visibility_off:Icons.visibility)),
                      label: Text("Password"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.grey.shade100),
                ),
                SizedBox(height: 20),

                ElevatedButton(onPressed: () async {

                  try {
                    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email.text,
                      password: _password.text,
                    );
                    print(credential);

                    // credential.user.email;
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');

                    Fluttertoast.showToast(
                        msg: "Password Is Weak Fill Strong Password Enter 6 letter or Number...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.purple.shade500,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    Fluttertoast.showToast(
                        msg: "Email Already Used Enter New Email",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    }
                  } catch (e) {
                    print(e);

                    Fluttertoast.showToast(
                      msg: "Something Wrong",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.purple.shade200,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return email_password();
                  },));

                }, child: Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),

              ]),
        ),
      ),
    );
  }
}
