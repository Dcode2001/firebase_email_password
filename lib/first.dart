import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_email_password/email_password.dart';
import 'package:firebase_email_password/google_login.dart';
import 'package:firebase_email_password/otpdemo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  @override
  void initState() {

    super.initState();

    cheakeckconn();
  }

  Future<void> cheakeckconn()
  async {
      var connecresult = await (Connectivity().checkConnectivity());

      if(connecresult == ConnectivityResult.none)
        {
          setState(() {
            print("No Connection");

          });

          CircularProgressIndicator();

          Fluttertoast.showToast(
              msg: "Not Connection...!!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
     else if(connecresult == ConnectivityResult.mobile)
      {
        setState(() {
          print("Mobile Connection on");
        });

        Fluttertoast.showToast(
            msg: "Mobile Connection on",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
     else if(connecresult == ConnectivityResult.wifi)
      {
        setState(() {
          print("Wifi Connection on");
        });

        Fluttertoast.showToast(
            msg: "Wifi Connection on",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(title: Text("Select Firebase Any Button")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return email_password();
              },));

            }, child: Text("Firebase Email")),

            SizedBox(height: 10),

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return otpdemo();
              },));

            }, child: Text("Firebase OTP")),

            SizedBox(height: 10),

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return googlelogin();
              },));

            }, child: Text("Firebase LOGIN WITH GOOGLE")),

            SizedBox(height: 10),
          ],
        ),
      ),
    ), onWillPop: goback);
  }

  Future<bool> goback()
  {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return first();
    },));
     return Future.value();
  }


}
