import '../../../../core/App_Imports/app_imports.dart';
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
    int carModel,
    String carNumber,
    GeoPoint location,
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
        carModel: carModel,
        carNumber: carNumber,
        location: location,
      );
      final locationmanager = LocationManager();
      final locationdata = await locationmanager.getUserLocation();
      if (locationdata != null) {
        final geoPoint = GeoPoint(
          locationdata.latitude!,
          locationdata.longitude!,
        );
        await firestore.collection('Driver').doc(uid).set({
          "id": uid,
          "name": name,
          "email": email,
          "phone": phone,
          "carModel": carModel,
          "carNumber": carNumber,
          "location": geoPoint,
          "status": "available",
          "isOnline": true,
          "updatedAt": FieldValue.serverTimestamp(),
        });
      }

      return UserEntity(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        phone: userModel.phone,
        carModel: userModel.carModel,
        carNumber: userModel.carNumber,
        location: userModel.location,
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
          .collection('Driver')
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
        carModel: userModel.carModel,
        carNumber: userModel.carNumber,
        location: userModel.location,
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
