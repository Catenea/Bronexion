import 'package:bronexion/authentication/authenticate.dart';
import 'package:bronexion/home/home.dart';
import 'package:flutter/material.dart';
import 'package:bronexion/models/User.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
