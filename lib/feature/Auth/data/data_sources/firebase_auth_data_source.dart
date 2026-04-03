import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uberCloneDriver/feature/Auth/data/models/auth_user_model.dart';

class FirebaseAuthDataSource {
  FirebaseAuthDataSource({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<AuthUserModel> register({
    required String email,
    required String password,
    required String name,
    required int phone,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;
    final user = AuthUserModel(
      id: uid,
      name: name,
      email: email,
      phone: phone,
    );

    await _firestore.collection('Admin').doc(uid).set({
      ...user.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc = await _firestore
        .collection('Admin')
        .doc(credential.user!.uid)
        .get();

    if (!doc.exists || doc.data() == null) {
      throw Exception('User data not found in Firestore');
    }

    return AuthUserModel.fromJson(doc.data()!);
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
