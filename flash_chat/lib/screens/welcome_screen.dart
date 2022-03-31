import 'package:flash_chat/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                const Text(
                  'Flash Chat',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            CustomButton(
              name: "Log In",
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, "/login");
              },
              buttonColor: Colors.lightBlueAccent,
            ),
            CustomButton(
              name: "Register",
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, "/register");
              },
              buttonColor: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}


