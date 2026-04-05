import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  Future<UserCredential> login(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() {
    return firebaseAuth.signOut();
  }
}
