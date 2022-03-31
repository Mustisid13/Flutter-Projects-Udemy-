import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/welcomeScreen": (context) => WelcomeScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegistrationScreen(),
        "/chatScreen": (context) => ChatScreen()
      },
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black54)
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}