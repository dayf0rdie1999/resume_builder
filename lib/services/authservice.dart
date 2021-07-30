import 'package:firebase_auth/firebase_auth.dart';
import 'package:resume_builder/module/user.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ResumeUser? _userFromFirebaseUser(User? user){
    return user != null ? ResumeUser(id: user.uid) : null;
  }

  // getting Stream of user
  Stream<ResumeUser?> get user {
    signInAnnoy();
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Todo: Sign In Annoymously
  Future<String?> signInAnnoy() async {

    try {
      UserCredential userCredential = await _auth.signInAnonymously();
    } on FirebaseException catch (e) {
      return e.toString();
    } catch(e) {
      return e.toString();
    }

  }

}