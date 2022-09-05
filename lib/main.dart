import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_email_password/demo.dart';
import 'package:firebase_email_password/first.dart';
import 'package:firebase_email_password/google_login.dart';
// import 'package:firebase_email_password/internetconnection_cheak.dart';
import 'package:firebase_email_password/otpdemo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'email_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // to initilize app with firebase aa line firebase thi conect thase..
  runApp(MaterialApp(
    // home: MyApp(),
    // home: email_password(),
    home: first(),
    // home: MyApp(),
    // home: googlelogin(),
  ));
}