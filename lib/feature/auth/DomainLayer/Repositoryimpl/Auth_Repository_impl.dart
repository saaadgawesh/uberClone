import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneRider/feature/Auth/dataLayer/models/UserModel.dart';
import 'package:uberCloneRider/feature/Auth/dataLayer/repository/AuthRepository.dart';

class AuthRepositoryImpl implements Authrepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  //*********************************************************** */
  //**** login ********** */
  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: "sa@g.com",
        password: "12345678",
      );

      final doc = await firestore
          .collection('Rider')
          .doc(credential.user!.uid)
          .get();

      if (!doc.exists) {
        throw Exception('data not found');
      } else {
        final userModel = Usermodel.fromjson(doc.data()!);

        return UserEntity(
          id: userModel.id,
          name: userModel.name,
          email: userModel.email,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'expired-action-code') {
        throw Exception('expired-action-code');
      } else if (e.code == 'invalid-email') {
        throw Exception('invalid-email');
      } else if (e.code == 'user-disabled') {
        throw Exception('user-disabled');
      } else {
        throw Exception(e.message ?? 'unknown error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //************************************************************** */
  //***** register ******** */
  @override
  Future<UserEntity> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: "sa@g.com",
        password: "12345678",
      );

      final userModel = Usermodel(
        id: credential.user!.uid,
        name: name,
        email: email,
      );

      await firestore
          .collection('Rider')
          .doc(userModel.id)
          .set(userModel.tojson());

      return UserEntity(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('email-already-in-use');
      } else if (e.code == 'invalid-email') {
        throw Exception('invalid-email');
      } else if (e.code == 'weak-password') {
        throw Exception('weak-password');
      } else {
        throw Exception(e.message ?? 'unknown error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //********************************************************* */
  //***** logout *********** */
  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
