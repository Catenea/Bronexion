import 'package:bronexion/home/Posts/post_card.dart';
import 'package:bronexion/home/Posts/upload_posts.dart';
import 'package:bronexion/models/posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostsHome extends StatefulWidget {
  PostsHome({Key key}) : super(key: key);

  @override
  _PostsHomeState createState() => _PostsHomeState();
}

class _PostsHomeState extends State<PostsHome> {
  List<Posts> postList = [];
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    dbRef.child("Posts").once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postList.clear();
      for (var key in keys) {
        Posts post = Posts(
            image: data[key]["Image"],
            description: data[key]["Description"],
            time: data[key]["Time"],
            date: data[key]["Date"]);
        postList.add(post);
      }

      DateFormat dateformat = DateFormat("MMM d,y");
      DateFormat timeformat = DateFormat("EEEE, hh:mm aaa");
      postList.sort((a, b) {
        var adate = dateformat.parse(a.date);
        var bdate = dateformat.parse(b.date);
        int comp = -adate.compareTo(bdate);
        if (comp != 0) {
          return comp;
        }
        var atime = timeformat.parse(a.time);
        var btime = timeformat.parse(b.time);
        return -atime.compareTo(btime);
      });

      setState(() {
        print("Largo: " + postList.length.toString());
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 40, 40, 40),
        child: ListView.builder(
            itemCount: postList.length,
            itemBuilder: (_, index) {
              return PostCard(post: postList[index]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return UploadPosts();
            },
          ));
        },
        child: Icon(Icons.add_a_photo, color: Colors.black),
        backgroundColor: Color.fromARGB(255, 255, 232, 131),
      ),
    );
  }
}
