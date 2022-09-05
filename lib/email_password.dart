import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email_password/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class email_password extends StatefulWidget {
  const email_password({Key? key}) : super(key: key);

  @override
  State<email_password> createState() => _email_passwordState();
}

class _email_passwordState extends State<email_password> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool tpass = true;
  bool tpass1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMAIL & PASSWORD REGISTER AND SIGN IN"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                        },
                        icon: Icon(
                            tpass1 ? Icons.visibility_off : Icons.visibility)),
                    label: Text("Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: Colors.grey.shade100),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                      Fluttertoast.showToast(
                          msg: "Login Sucessfully....",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      print(credential);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');

                        Fluttertoast.showToast(
                            msg: "Email Id Not Found ...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.purple.shade500,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');

                        Fluttertoast.showToast(
                            msg: "Wrong Password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      else
                        {
                          print('Not Login.');

                          Fluttertoast.showToast(
                              msg: "Not Login",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                    }


                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Are You Need An Account?",style: TextStyle(fontSize: 16),),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return register();
                      },));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
