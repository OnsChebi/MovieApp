import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmood/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Convert Firebase User to UserModel
  UserModel? _userFromFirebase(User? user) {
    if (user != null) {
      return UserModel(
        id: user.uid.hashCode, 
        name: user.displayName ?? '',
        email: user.email,
        password: '',
        confirmpassword: '',
      );
    }
    return null;
  }

  // Stream for auth changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // Sign Up
  Future<UserModel?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(result.user);
      
    } catch (e) {
      print("error during sign up: $e");
      throw e;
    }
  }

  // Login
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(result.user);
    } catch (e) {
      //print('error during login $e');
     throw e;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
