import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  // String email = "";
  // String password = "";
  bool showSpinner = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 50,8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      // onChanged: (value) {
                      //   email = value;
                      // },
                      controller: emailController,
                      decoration: kTextFieldDecoration,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      // onChanged: (value) {
                      //   password = value; //Do something with the user input.
                      // },
                      controller: passwordController,
                      decoration: kTextFieldDecoration,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user = await _auth
                                  .signInWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim())
                                  .then((value) =>
                                      Navigator.pushNamed(context, ChatScreen.id));
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Log In',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
