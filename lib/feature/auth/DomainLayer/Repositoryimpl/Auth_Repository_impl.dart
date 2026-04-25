

import 'package:injectable/injectable.dart';
import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

@LazySingleton(as: Authrepository)
class AuthRepositoryImpl implements Authrepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> _getFcmTokenSafely() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  // ================= REGISTER =================
  @override
  Future<UserEntity> register(
    String email,
    String password,
    String name,
    int phone,
  ) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final credential = await auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      final uid = credential.user!.uid;

      final userModel = Usermodel(
        id: uid,
        name: name,
        email: normalizedEmail,
        phone: phone,
      );

      final fcmToken = await _getFcmTokenSafely();
      await firestore.collection('Rider').doc(uid).set({
        "id": uid,
        "name": name,
        "email": normalizedEmail,
        "phone": phone,
        "fcmToken": fcmToken,

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
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'firestore-write-failed');
    }
  }

  // ================= LOGIN =================
  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final credential = await auth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      final doc = await firestore
          .collection('Rider')
          .doc(credential.user!.uid)
          .get();

      final fcmToken = await _getFcmTokenSafely();
      await firestore.collection('Rider').doc(credential.user!.uid).set({
        if (fcmToken != null) 'fcmToken': fcmToken,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!doc.exists) {
        throw Exception(
          'Authenticated with Firebase, but rider profile was not found in Firestore.',
        );
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
        case 'invalid-credential':
          throw Exception('invalid-email-or-password');
        case 'wrong-password':
          throw Exception('invalid-email-or-password');
        default:
          throw Exception(e.message ?? 'login-failed');
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'firestore-read-failed');
    }
  }

  // ================= LOGOUT =================
  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
