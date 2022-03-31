import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String message = "";
  late TextEditingController textController;

  getCurrentUser() async{
    loggedInUser = _auth.currentUser!;
    print(loggedInUser!.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection("messages").add({
                        "sender":loggedInUser!.email,
                        "text":message
                      });
                      textController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
          List<Widget> textWidgets = [];
          if(snapshot.hasData){
            final messages = snapshot.data!.docs.reversed;
            for(var message in messages){
              final messageText = (message.data() as Map)["text"];
              final messageSender = (message.data() as Map)["sender"];
              textWidgets.add(MessageBubble(isMe:loggedInUser!.email == messageSender, sender: messageSender, text: messageText));
            }
            return ListView(
              reverse: true,
              shrinkWrap: true,
              children: textWidgets,
            );
          }
          return const CircularProgressIndicator();
        });
  }
}


class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  const MessageBubble({Key? key,required this.sender,required this.text,required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,style: const TextStyle(fontSize: 12,color: Colors.black54),),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(topRight: isMe? Radius.circular(0) :Radius.circular(30),topLeft:isMe? Radius.circular(30) :Radius.circular(0) ,bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            color: isMe? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 15,color: isMe? Colors.white: Colors.black),
          ),
            )
          ),
        ],
      ),
    );
  }
}
