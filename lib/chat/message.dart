import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, idx){
              return Text(chatDocs[idx]["text"]);
            });
    },
    );
  }
}
