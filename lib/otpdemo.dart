import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class otpdemo extends StatefulWidget {
  const otpdemo({Key? key}) : super(key: key);

  @override
  State<otpdemo> createState() => _otpdemoState();
}

class _otpdemoState extends State<otpdemo> {
  TextEditingController tcontact = TextEditingController();
  TextEditingController tsmscode = TextEditingController();

  OtpFieldController otpController = OtpFieldController();

  String mverificationId = "";

  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otp Sent Firebase"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: tcontact,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.phone),
                  label: Text("Contact Number"),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    String contactno = tcontact.text;

                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91$contactno',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        mverificationId = verificationId;
                        Fluttertoast.showToast(
                            msg: "Otp Sent Sucessfully...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        Fluttertoast.showToast(
                            msg: "Time out",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                    );
                  },
                  child: Text("Send Otp")),

              SizedBox(height: 25),

              Divider(thickness: 5,color: Colors.black,),

              SizedBox(height: 25),

              // TextField(controller: tsmscode),

              OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.black,
                cursorColor: Colors.black,
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                },
                onSubmit: (String verificationCode) {
                  // String smsCode = tsmscode.text;

                  smsCode = verificationCode;
                }, // end onSubmit
              ),

              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    // String smsCode = tsmscode.text;

                    otpController.clear();

                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: mverificationId, smsCode: smsCode);

                    // Sign the user in (or link) with the credential
                    await FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) {
                      print(value);

                      Fluttertoast.showToast(
                          msg: "Verify SucessFully.......",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 4,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      if (value.user!.phoneNumber != null) {

                        Fluttertoast.showToast(
                            msg: "Verify Next Page.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 4,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Text("Verify"))
            ]),
      )),
    );
  }
}
