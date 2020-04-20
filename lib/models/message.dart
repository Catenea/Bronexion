import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final String from;
  final bool me;
  const Message({Key key, this.text, this.from, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
            style: TextStyle(color: Colors.grey),
          ),
          Material(
              color: me ? Color.fromARGB(255, 138, 130, 47) : Colors.grey[700],
              borderRadius: BorderRadius.circular(10.0),
              elevation: 0.0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }
}
