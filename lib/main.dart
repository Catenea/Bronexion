import 'package:bronexion/models/User.dart';
import 'package:bronexion/services/auth.dart';
import 'package:bronexion/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthServices().user, child: MaterialApp(home: Wrapper()));
  }
}
