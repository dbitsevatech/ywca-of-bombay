// https://github.com/davefaliskie/travel_treasury/tree/episode_20/lib
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((User user) => user?.uid);

  // // Email & Password Sign Up
  // Future<String> createUserWithEmailAndPassword(
  //     String email, String password, String name) async {
  //   final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   // Update the username
  //   var userUpdateInfo = UserUpdateInfo();
  //   userUpdateInfo.displayName = name;
  //   await currentUser.updateProfile(userUpdateInfo);
  //   await currentUser.reload();
  //   return currentUser.uid;
  // }

  // // Email & Password Sign In
  // Future<String> signInWithEmailAndPassword(
  //     String email, String password) async {
  //   return (await _firebaseAuth.signInWithEmailAndPassword(
  //           email: email, password: password))
  //       .uid;
  // }

  // Phone Auth

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }
}
