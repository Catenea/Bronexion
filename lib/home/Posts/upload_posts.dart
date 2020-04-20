import 'package:bronexion/home/Posts/posts_form.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UploadPosts extends StatefulWidget {
  UploadPosts({Key key}) : super(key: key);

  @override
  _UploadPostsState createState() => _UploadPostsState();
}

class _UploadPostsState extends State<UploadPosts> {
  File sampleImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Upload Post",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 232, 131), fontSize: 20.0),
        ),
      ),
      body: sampleImage == null
          ? Center(
              child: FlatButton(
              onPressed: () async {
                var tempImage =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {
                  sampleImage = tempImage;
                });
              },
              child: Text(
                "Select Image",
                style: TextStyle(fontSize: 20.0),
              ),
              color: Color.fromARGB(255, 255, 232, 131),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            ))
          : PostForm(sampleImage: sampleImage),
    );
  }
}
