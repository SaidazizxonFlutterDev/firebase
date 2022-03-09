import 'package:fire_base_first/screens/home_page.dart';
import 'package:fire_base_first/services/firebase_signup_signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _firebaseInit = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "FireBase",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: _firebaseInit,
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snap.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                        child: const Text("SIgn Up"),
                        onPressed: () async {
                          await SignUpAndSignIn.signUpWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            if (value != null) {
                              return Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Emaildan avval ro'yxatdan o'tilgan"),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: const Text("Sign In"),
                        onPressed: () async {
                          await SignUpAndSignIn.signIn(_emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            if (value) {
                              return Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Email yoki parol noto'g'ri kiritildi"),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      TextButton(
                        child: const Text("RESET PASSWORD"),
                        onPressed: () {
                          SignUpAndSignIn.resetPassword().then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "PAROLNI TIKLASH UCHUN EMAIL JONATILDI"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("EMAIL TOPILMADI"),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Login WIth Phone NUmber'),
                        onPressed: () {
                          SignUpAndSignIn.verifySms(context, _emailController.text);
  
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
