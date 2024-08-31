import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fertilizerapp/models/FarmerDetailmodel.dart';

//collection name in DataBase
const String FARMER_COLLECTION_REF = "farmer";

class FarmerDatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _faremerRef;

//json  withconverter
  FarmerDatabaseServices() {
    _faremerRef = _firestore
        .collection(FARMER_COLLECTION_REF)
        .withConverter<Farmer>(
            fromFirestore: (snapshots, _) => Farmer.fromJson(snapshots.data()!),
            toFirestore: (farmer, _) => farmer.toJson());
  }

  //get todo from database
  Stream<QuerySnapshot> getfarmers() {
    return _faremerRef.snapshots();
  }

  //add todo to databse
  void addfarmer(Farmer farmer) async {
    _faremerRef.add(farmer);
  }

  //update todo
  void updatefarmer(String farmerId, Farmer farmer) {
    _faremerRef.doc(farmerId).update(farmer.toJson());
  }

  //deleted todo
  void deletefarmer(String farmerId) {
    _faremerRef.doc(farmerId).delete();
  }

   Future<void> addFertilizerBill(
      String farmerId, String type, String price, String amount, String dateTime) async {
    try {
      // Reference to the "fertilizer bill" sub-collection
      CollectionReference fertilizerBill = _firestore
          .collection('farmer')
          .doc(farmerId)
          .collection('fertilizer bill');

      // Add a new document to the "fertilizer bill" sub-collection
      await fertilizerBill.add({
        'type': type,
        'price': double.parse(price),
        'amount': double.parse(amount),
        'purchasedate': dateTime,
      });

      print('Fertilizer bill added successfully');
    } catch (e) {
      print('Error adding fertilizer bill: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getFertilizerBills(String farmerId) async {
  List<Map<String, dynamic>> fertilizerBillList = [];

  try {
    CollectionReference fertilizerBill = _firestore
        .collection('farmer')
        .doc(farmerId)
        .collection('fertilizer bill');

    QuerySnapshot querySnapshot = await fertilizerBill.get();

    for (var doc in querySnapshot.docs) {
      fertilizerBillList.add({
        'id': doc.id, // Add the document ID to the map
        ...doc.data() as Map<String, dynamic>
      });
    }

    print('Fertilizer bills retrieved successfully');
  } catch (e) {
    print('Error retrieving fertilizer bills: $e');
  }

  return fertilizerBillList;
}

 Future<void> deleteDailyCollectionData(String farmerId, String docId) async {
    try {
      // Reference to the daily collection document to delete
      CollectionReference dailyCollection = _firestore
          .collection('farmer')
          .doc(farmerId)
          .collection('fertilizer bill');

      // Delete the specified document using its ID
      await dailyCollection.doc(docId).delete();

      print('Daily Collection data deleted successfully');
    } catch (e) {
      print('Error deleting daily collection data: $e');
    }
  }

}
