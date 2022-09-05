import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog/Models/user_model.dart';

class authServices {
  final FirebaseAuth _auth;
  authServices(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signout() async {
    await _auth.signOut();
  }

  Usermodel getcurrentuser() {
    Usermodel user = Usermodel(_auth.currentUser?.uid,
        _auth.currentUser?.displayName, _auth.currentUser?.email);
    return user;
  }

  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    print(email);
    try {
      print(password);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('resgiring done');
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signWithEmailAndPassword(
      String email, String password) async {
    print('called');
    try {
      print('called2');
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('called3');
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      print('firebase error');
      return e.message;
    }
  }
}
