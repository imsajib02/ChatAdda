import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:chatadda/widgets/widgets_collection.dart';
import 'package:chatadda/pages/chat_screen.dart';

class MyClass {

  //static BuildContext context;
  static var dialog;
  static String snack_msg = "";
  static UserDetails loggeduser;

  static List messages = [];

  static GoogleSignIn googleSignIn = new GoogleSignIn();

  static DisplayProgressDialog(BuildContext context, String msg, {double radius: 0.0, Color color: Colors.black})
  {
    dialog = showProgressDialog(context: context,
      loadingText: msg,
      radius: radius,
      backgroundColor: color,
    );
  }

  static DisplayErrorSnack(BuildContext context, String msg)
  {
    Flushbar(
      message: msg,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(8),
      isDismissible: false,
      borderRadius: 8.0,
      duration: Duration(seconds: 3),
    ).show(context);
  }

  static void GoogleLogin(BuildContext context)
  {
    //SignOutofGoogle(context);

    try {
      googleSignIn.signIn().then((result){

        result.authentication.then((account) {

          DisplayProgressDialog(context, 'Please wait ...', radius: 8.0, color: Colors.black);

          AuthCredential credential = GoogleAuthProvider.getCredential(
              idToken: account.idToken,
              accessToken: account.accessToken);

          FirebaseAuth.instance.signInWithCredential((credential)).then((user) {

            if(user != null) {

              dialog.dismiss();
              loggeduser = new UserDetails(user.user.displayName, user.user.email, user.user.photoUrl);
              print(loggeduser.getUserName());

              NavigateTo(context, ChatScreen());
            }

          }).catchError((error) {

            dialog.dismiss();
            print('Sign-in with Credential: $error');

            snack_msg = 'Sign-in failed. Try again.';
            DisplayErrorSnack(context, snack_msg);
          });

        }).catchError((error) {

          dialog.dismiss();
          print('Authentication: $error');

          snack_msg = 'Authentication failed';
          DisplayErrorSnack(context, snack_msg);
        });

      }).catchError((error) {

        print('Sign-in: $error');

        snack_msg = 'Some error occured. Try again.';
        DisplayErrorSnack(context, snack_msg);
      });

    } catch(error) {

      print('Try-Catch: $error');

      //snack_msg = 'Some error occured. Try again.';
      //DisplayErrorSnack(context, snack_msg);
    }

  }

  static void SignOutofGoogle(BuildContext context)
  {
    googleSignIn.signOut();
    Navigator.pop(context);
  }

  static void NavigateTo(BuildContext context, Widget route) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }
}

class UserDetails {

  final String userName;
  final String userEmail;
  final String photoUrl;

  UserDetails(this.userName, this.userEmail, this.photoUrl);

  String getUserName() {return this.userName;}

  String getUserEmail() {return this.userEmail;}

  String getPhotoUrl() {return this.photoUrl;}
}