import "package:firebase_auth/firebase_auth.dart";

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Future<void> signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print("No user found for that email.");
  //     } else if (e.code == 'wrong-password') {
  //       print("Wrong password provided for that user.");
  //     }
  //   }
  // }

  // Future<void> createUserWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print("The password provided is too weak.");
  //     } else if (e.code == 'email-already-in-use') {
  //       print("The account already exists for that email.");
  //     }
  //   }
  // }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
