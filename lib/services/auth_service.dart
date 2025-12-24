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
      // 1. Daftarkan user ke Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) return null;

      // 2. Ambil Unique ID (UID) yang otomatis dibuat oleh Firebase
      String uid = userCredential.user!.uid;

      // 3. Simpan data tambahan (username & email) ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'fullName': fullName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'createdAt': DateTime.now(),
      });
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // LOGIN
  Future<User?> login({
    required String email,
    required String password,
  }) async {
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
