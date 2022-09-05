import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googlelogin extends StatefulWidget {
  const googlelogin({Key? key}) : super(key: key);

  @override
  State<googlelogin> createState() => _googleloginState();
}

class _googleloginState extends State<googlelogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Google Firebase.."),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {

                signInWithGoogle().then((value)
                {
                    print(value);
                    debugPrint("$value");
                    Fluttertoast.showToast(
                        msg: "Login with Google Sucessfully....",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                }
                );
              }, child: Text("Login With Google")),


              SizedBox(height: 20),

              Divider(height: 50,thickness: 5,color: Colors.black,),

              ElevatedButton(onPressed: () async {

                await GoogleSignIn().signOut().then((value)
                {
                    print("Log Out");
                    debugPrint("$value");
                    Fluttertoast.showToast(
                        msg: "Log Out",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                }
                );
              }, child: Icon(Icons.exit_to_app_outlined))
            ]
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
