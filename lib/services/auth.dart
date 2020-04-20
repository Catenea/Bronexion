import 'package:bronexion/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User from FirebaseUser
  User _convertToUser(FirebaseUser firebaseUser) {
    return firebaseUser == null
        ? null
        : User(uid: firebaseUser.uid, email: firebaseUser.email);
  }

  //Auth change user Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_convertToUser);
  }

  //Sign in anon

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _convertToUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //Sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //login with email and password

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _convertToUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Register with email and password

  Future registerWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _convertToUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
