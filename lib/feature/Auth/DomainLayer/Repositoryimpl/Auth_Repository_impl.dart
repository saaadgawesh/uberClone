import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uberCloneDriver/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneDriver/feature/Auth/dataLayer/models/Usermodel.dart';
import 'package:uberCloneDriver/feature/Auth/dataLayer/repository/AuthRepository.dart';

class AuthRepositoryImpl implements Authrepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ================= REGISTER =================
  @override
  Future<UserEntity> register(
    String email,
    String password,
    String name,
    int phone,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      final userModel = Usermodel(
        id: uid,
        name: name,
        email: email,
        phone: phone,
      );

      await firestore.collection('Admin').doc(uid).set({
        "id": uid,
        "name": name,
        "email": email,
        "phone": phone,

        "updatedAt": FieldValue.serverTimestamp(),
      });

      return UserEntity(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        phone: userModel.phone,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('email-already-in-use');
        case 'invalid-email':
          throw Exception('invalid-email');
        case 'weak-password':
          throw Exception('weak-password');
        default:
          throw Exception(e.message ?? 'register-failed');
      }
    }
  }

  // ================= LOGIN =================
  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await firestore
          .collection('Admin')
          .doc(credential.user!.uid)
          .get();

      if (!doc.exists) {
        throw Exception('User data not found in Firestore');
      }

      final userModel = Usermodel.fromjson(doc.data()!);

      return UserEntity(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        phone: userModel.phone,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception('invalid-email');
        case 'user-disabled':
          throw Exception('user-disabled');
        case 'user-not-found':
          throw Exception('user-not-found');
        case 'wrong-password':
          throw Exception('wrong-password');
        default:
          throw Exception(e.message ?? 'login-failed');
      }
    }
  }

  // ================= LOGOUT =================
  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
