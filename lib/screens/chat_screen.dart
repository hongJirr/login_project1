
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_project1/chat/newMessage.dart';

import '../chat/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    try{
      final user = _authentication.currentUser;
      if(user != null){
        loggedUser = user;
        print(loggedUser!.email);
      }
    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat screen"),
        actions: [
          IconButton(onPressed: (){
            _authentication.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text("success logout"), backgroundColor: Colors.black.withOpacity(0.7), )
            );
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        child: Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              NewMessages(),
            ]
        ),
      )
    );
  }
}
