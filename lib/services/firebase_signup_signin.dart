import 'package:fire_base_first/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpAndSignIn {
  static final FirebaseAuth authUser = FirebaseAuth.instance;
  static final User? currentUser = FirebaseAuth.instance.currentUser;

  static Future signUpWithEmailAndPassword(String e, String p) async {
    try {
      UserCredential _credential =
          await authUser.createUserWithEmailAndPassword(email: e, password: p);
      User? _user = _credential.user;
      await _user!.sendEmailVerification();
      debugPrint("USER: ${_user.email}");
      return true;
    } catch (e) {
      debugPrint("UserSignUpErorr !!!!!!!: $e");
    }
  }

  static Future signIn(String e, String p) async {
    if (authUser.currentUser == null) {
      try {
        UserCredential? _signedUser =
            await authUser.signInWithEmailAndPassword(email: e, password: p);
        return true;
      } catch (e) {
        print("SIGN IN ERROR: $e");
        return false;
      }
    }
  }

  static Future resetPassword() async {
    String email = "smister702@gmail.com";
    try {
      await authUser.sendPasswordResetEmail(email: email);
      print("EMAIL JONATILDI");
      return true;
    } catch (e) {
      print("RESET PASSWORD ERROR: $e");
      return false;
    }
  }

  static Future verifySms(BuildContext context, String number) async {
    await authUser.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (v) {
          print("VERIFICATION COMPLETED");
          
        },
        verificationFailed: (v) {
          print("VERIFICATION FAILED $v");
        },
        codeSent: (verificationId, resendToken) async {
          print("CODE IS SENT");
          String smsCode = "112233";
          PhoneAuthCredential _phoneCredential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          await authUser.signInWithCredential(_phoneCredential).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }
}
