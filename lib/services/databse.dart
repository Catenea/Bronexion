import 'package:bronexion/models/posts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final StorageReference postImageRef =
      FirebaseStorage.instance.ref().child("Posts Images");

  final DatabaseReference dbRef = FirebaseDatabase.instance.reference();

  //Upload Images in Storage
  Future uploadImage(File sampleImage) async {
    print("Subiendo Imagen");
    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
    var imgUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    print("URl de la imagen: " + imgUrl.toString());
    return imgUrl.toString();
  }

  //Create Docs in database
  Future uploadPost(String url, String description) async {
    print("Creando Documento");
    var timeKey = new DateTime.now();

    var formatDate = DateFormat("MMM d,y");
    var formatTime = DateFormat("EEEE, hh:mm aaa");

    String date = formatDate.format(timeKey);
    String time = formatTime.format(timeKey);
    var data = {
      "Image": url,
      "Description": description,
      "Date": date,
      "Time": time
    };
    print("Creando Documento con los datos: Url: " +
        url +
        " Descripcion: " +
        description);
    dbRef.child("Posts").push().set(data);
  }

  //Act Posts Feed
  Future actFeed() async {
    List<Posts> postList = [];

    return postList;
  }
}
