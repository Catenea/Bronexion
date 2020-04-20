import 'package:bronexion/models/posts.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Posts post;
  PostCard({this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      color: Colors.black,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    post.date,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    post.time,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Image.network(post.image, fit: BoxFit.cover),
              SizedBox(
                height: 10.0,
              ),
              Text(
                post.description,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ],
          )),
    );
  }
}
