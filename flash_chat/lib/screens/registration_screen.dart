import 'package:flash_chat/constants.dart';
import 'package:flash_chat/custom_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kFieldDecoration("Enter Your Email"),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kFieldDecoration("Enter Your Password"),
                  style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomButton(name: "Register", buttonColor: Colors.blueAccent, onPressed: () async{

                try {
                  setState(() {
                    _loading = true;
                  });
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email!, password: password!);
                      if(newUser != null){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                      }
                      setState(() {
                       _loading=false;
                      });
                    } catch(e){
                  print(e);
                }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
