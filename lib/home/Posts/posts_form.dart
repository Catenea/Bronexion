import 'package:bronexion/home/home.dart';
import 'package:bronexion/services/databse.dart';
import "package:flutter/material.dart";
import 'dart:io';

class PostForm extends StatefulWidget {
  File sampleImage;
  PostForm({Key key, this.sampleImage}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  DatabaseServices _db = DatabaseServices();
  String imgUrl;
  String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(255, 255, 232, 131),
                  child: Image.file(
                    widget.sampleImage,
                    height: 330.0,
                    width: 660.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Divider(color: Color.fromARGB(255, 255, 232, 131)),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Description",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 232, 131),
                                width: 2.0))),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      return val.isEmpty ? "Description is required" : null;
                    },
                    onChanged: (val) {
                      description = val;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                    color: Color.fromARGB(255, 255, 232, 131),
                    icon: Icon(Icons.send),
                    label: Text("Publicar"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        imgUrl = await _db.uploadImage(widget.sampleImage);
                        await _db.uploadPost(imgUrl, description);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Home();
                        }));
                      }
                    }),
                SizedBox(height: 10.0)
              ],
            ),
          )),
    );
  }
}
