import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  late final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signinWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(
          'User with this email id does not exist. Please sign up',
        );
      }
      if (e.code == 'wrong-password') {
        throw AuthException('You have entered the wrong password');
      }
    }
  }

  Future<void> signInWithCredential(AuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(
          'User with this email id does not exist. Please sign up',
        );
      }
      if (e.code == 'wrong-password') {
        throw AuthException('You have entered the wrong password');
      }
    }
  }

  Future<UserCredential?> signupWithEmailPassword(
      String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('This email is already in use');
      }
      if (e.code == 'weak-password') {
        throw AuthException('The password is not strong enough');
      }
    }
    return userCredential;
  }

  Future<void> signInWithGoogle() async {
    final googleAuth = await GoogleSignIn().signIn().then(
          (googleUser) async => await googleUser?.authentication,
        );

    if (googleAuth != null) {
      await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ),
      );
    }
  }

  Future<void> signOut() async => _firebaseAuth.signOut();
}

class AuthException {
  final String message;

  AuthException(this.message);
}
