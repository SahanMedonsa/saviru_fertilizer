import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fertilizerapp/models/fertilizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Update to your actual model path

// Collection name in Firestore
const String OUTLET_COLLECTION_REF = "fertilizer";

class OutletDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Outlet> _outletRef;
    String? get username => FirebaseAuth.instance.currentUser?.email;

  OutletDatabaseServices() {
    _outletRef = _firestore.collection(OUTLET_COLLECTION_REF).withConverter<Outlet>(
      fromFirestore: (snapshot, _) => Outlet.fromJson(snapshot.data()!),
      toFirestore: (outlet, _) => outlet.toJson(),
    );
  }

  // Get outlets from database as a stream
  Stream<QuerySnapshot<Outlet>> getOutlets() {
    return _outletRef.where('username', isEqualTo: username ?? '').snapshots();
  }

  // Add outlet to database
  Future<void> addOutlet(Outlet outlet) async {
    await _outletRef.add(outlet);
  }

  // Update outlet in database
  Future<void> updateOutlet(String outletId, Outlet updatedOutlet) async {
    await _outletRef.doc(outletId).set(updatedOutlet);
  }

  // Delete outlet from database
  Future<void> deleteOutlet(String outletId) async {
    await _outletRef.doc(outletId).delete();
  }
}
