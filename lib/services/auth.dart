import 'package:firebase_auth/firebase_auth.dart';
import 'package:cross_border/models/student.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based of FB user
  ModelUser _userFromFirebaseUser(User user) {
    return user != null ? ModelUser(uuid: user.uid) : null;
  }

  //auth change user stream
  Stream<ModelUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  //register with email and password
  Future registerEmailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String getUid() {
    return _auth.currentUser.uid;
  }

  String getEmail() {
    return _auth.currentUser.email;
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
