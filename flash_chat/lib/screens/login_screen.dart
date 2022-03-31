import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/custom_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kFieldDecoration("Enter Email"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kFieldDecoration("Enter Password"),
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomButton(
                  name: "Log In",
                  buttonColor: Colors.lightBlueAccent,
                  onPressed: () {
                    if (email != null && password != null) {
                      setState(() {
                        _loading = true;
                      });
                      try {
                        final user = _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);
                        if (user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen()));
                        }
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          _loading = false;
                        });
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
