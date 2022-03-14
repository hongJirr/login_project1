import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                onChanged: (value){
                  setState(() {
                    _message = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Send a message..",
                ),
              ),
          ),
          IconButton(
              onPressed: (){
                print(_message.isEmpty);
              }, icon: const Icon(Icons.send, color: Colors.blue,))
        ],
      ),
    );
  }
}
