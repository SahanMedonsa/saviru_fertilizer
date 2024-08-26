import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableStockService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateAvailableStock(
      String documentId, Map<String, dynamic> stockData) async {
    try {
      // Reference to the "available stock" collection
      DocumentReference stockDocument = _firestore
          .collection('fertilizer')
          .doc('4nwd0gp8GJM0u2aYv')
          .collection('Available stock')
          .doc(documentId);

      // Set data for the document (will create or update)
      await stockDocument.set(stockData);

      print('Available stock added/updated successfully');
    } catch (e) {
      print('Error adding/updating available stock: $e');
    }
  }

  Future<Map<String, dynamic>?> getAvailableStock(String documentId) async {
    try {
      // Reference to the specific stock document
      DocumentReference stockDocument = _firestore
          .collection('fertilizer')
          .doc('4nwd0gp8GJM0u2aYv')
          .collection('Available stock')
          .doc(documentId);

      DocumentSnapshot docSnapshot = await stockDocument.get();

      if (docSnapshot.exists) {
        print('Available stock retrieved successfully');
        return docSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('No document found with the given ID');
        return null;
      }
    } catch (e) {
      print('Error retrieving available stock: $e');
      return null;
    }
  }

  Future<void> deleteAvailableStock(String documentId) async {
    try {
      // Reference to the stock document to delete
      DocumentReference stockDocument = _firestore
          .collection('fertilizer')
          .doc('4nwd0gp8GJM0u2aYv')
          .collection('Available stock')
          .doc(documentId);

      // Delete the specified document
      await stockDocument.delete();

      print('Available stock deleted successfully');
    } catch (e) {
      print('Error deleting available stock: $e');
    }
  }
}
