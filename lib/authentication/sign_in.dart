import 'package:bronexion/services/auth.dart';
import 'package:bronexion/shared/constants.dart';
import 'package:flutter/material.dart';

class Sign_In extends StatefulWidget {
  final Function toggleView;
  Sign_In({Key key, this.toggleView}) : super(key: key);

  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 40, 40),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0.0,
          title: Text("Sign in to Bronexion",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 232, 131), fontSize: 20.0)),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"),
              textColor: Color.fromARGB(255, 255, 232, 131),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: textInputDecor.copyWith(hintText: "Email"),
                    validator: (val) =>
                        val.isEmpty ? "ingrese un correo" : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: textInputDecor.copyWith(hintText: "Password"),
                    validator: (val) => val.length < 8
                        ? "La contraseña debe tener al menos 8 caracteres"
                        : null,
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(height: 20.0),
                  FlatButton(
                    child: Text("Sign in"),
                    color: Color.fromARGB(255, 255, 232, 131),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.signInWithEmail(email, password);
                        if (result == null) {
                          setState(() {
                            error = "Error signing in";
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    error,
                    style: TextStyle(color: Color.fromARGB(255, 255, 232, 131)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
