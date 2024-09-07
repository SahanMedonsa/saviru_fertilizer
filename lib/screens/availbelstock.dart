import 'package:fertilizerapp/components/productcard.dart';
import 'package:fertilizerapp/models/availblestock.dart';
import 'package:fertilizerapp/service/availblestock_service.dart';
import 'package:fertilizerapp/service/outlet_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableStockList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FertilizerDatabaseServices _fertilizerService =
        FertilizerDatabaseServices();
    final OutletDatabaseServices _outletDatabaseServices =
        OutletDatabaseServices();

    return StreamBuilder<QuerySnapshot>(
      stream: _outletDatabaseServices.getOutlets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No data found'));
        }

        final userData = snapshot.data!.docs.first;
        String outletID = userData.id;

        return StreamBuilder<QuerySnapshot>(
          stream: _fertilizerService.getAvailableStock(outletID),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> collectionSnapshot) {
            if (collectionSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (collectionSnapshot.hasError) {
              return Center(child: Text('Error: ${collectionSnapshot.error}'));
            }

            if (!collectionSnapshot.hasData ||
                collectionSnapshot.data!.docs.isEmpty) {
              return Center(child: Text('No available stock found'));
            }

            final availableStockDocs = collectionSnapshot.data!.docs;

            return ListView.builder(
              itemCount: availableStockDocs.length,
              itemBuilder: (context, index) {
                final stock = AvailableStock.fromJson(
                    availableStockDocs[index].data() as Map<String, dynamic>);

                return Column(
                  children: [
                    ProductCard(
                        imagePath: "assets/pngwing.com (2).png",
                        productName: "Dolomite",
                        stockAmount: "${stock.dolomite}",
                        pricePerKg: "210.23"),
                    ProductCard(
                        imagePath: "assets/pngwing.com (2).png",
                        productName: "KIE",
                        stockAmount: "${stock.kie}",
                        pricePerKg: "321.00"),
                        

                        
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
