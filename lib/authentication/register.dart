import 'package:bronexion/services/auth.dart';
import 'package:bronexion/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            title: Text("Register in Bronexion",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 232, 131), fontSize: 20.0)),
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text("Sign in"),
                textColor: Color.fromARGB(255, 255, 232, 131),
              )
            ]),
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
                    decoration: textInputDecor.copyWith(hintText: "Correo"),
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
                    decoration: textInputDecor.copyWith(hintText: "Contraseña"),
                    validator: (val) => val.length < 8
                        ? "La contraseña debe tener al menos 8 caracteres"
                        : null,
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(height: 20.0),
                  FlatButton(
                    child: Text("Register"),
                    color: Color.fromARGB(255, 255, 232, 131),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerWithEmail(email, password);
                        if (result == null) {
                          setState(() {
                            error = "Error with register";
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
