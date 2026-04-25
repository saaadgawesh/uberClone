  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot> acceptedTripsStream() {
   String? riderId;
   riderId = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('trips')
        .where('riderId', isEqualTo: riderId)
        .snapshots();
  }
