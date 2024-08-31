import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fertilizerapp/models/availblestock.dart';

class FertilizerDatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('fertilizer');

  Stream<QuerySnapshot> getAvailableStock(String outletId) {
    return _collectionRef
        .doc(outletId)
        .collection('Available stock')
        .snapshots();
  }

   Future<void> addAvailableStock(String outletId, AvailableStock stock) async {
    try {
      // Reference to the "Available stock" sub-collection
      CollectionReference availableStockCollection = _collectionRef
          .doc(outletId)
          .collection('Available stock');

      // Add a new document to the "Available stock" sub-collection
      await availableStockCollection.add(stock.toJson());

      print('Available stock added successfully');
    } catch (e) {
      print('Error adding available stock: $e');
    }
  }

 
}
