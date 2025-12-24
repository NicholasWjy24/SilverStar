import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUser({
    required String email,
    required String password,
    required String username,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
    required String gender,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("Auth Successful!");

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': username,
          'fullName': fullName,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'createdAt': DateTime.now(),
        });
      }
      print("Database Save Successful!");
      return user;
    } on FirebaseAuthException catch (e) {
      print("Auth Error: ${e.code}");
      rethrow;
    } catch (e) {
      print("General Error: $e");
      rethrow;
    }
  }

  // LOGIN
  Future<User?> login({required String email, required String password}) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // CURRENT USER
  User? get currentUser => _auth.currentUser;
}
