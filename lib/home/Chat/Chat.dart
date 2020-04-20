import 'package:bronexion/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bronexion/models/User.dart';
import 'package:firebase_database/firebase_database.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  final Firestore _firestore = Firestore.instance;
  ScrollController scrollController = ScrollController();

  Future send(User user) async {
    print("Enviando");
    if (messageController.text.length > 0) {
      await _firestore.collection("Messages").add({
        "Text": messageController.text,
        "From": user.email,
        "Date": DateTime.now().toString()
      }).then((val) {
        print("Listo");
      });
      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _firestore.collection("Messages").orderBy("Date").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                List<DocumentSnapshot> docs = snapshot.data.documents;

                List<Widget> messages = docs
                    .map((doc) => Message(
                          from: doc.data["From"],
                          text: doc.data["Text"],
                          me: user.email == doc.data["From"],
                        ))
                    .toList();

                return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ]);
              },
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            color: Color.fromARGB(255, 255, 232, 131),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    cursorColor: Colors.transparent,
                    decoration: null,
                    controller: messageController,
                  ),
                ),
                FlatButton.icon(
                  onPressed: () => send(user),
                  icon: Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  label: Text(""),
                )
              ],
            ))
      ],
    ));
  }
}
