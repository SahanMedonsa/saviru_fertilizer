import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fertilizerapp/components/Gtext.dart';
import 'package:fertilizerapp/components/detailstext.dart';
import 'package:fertilizerapp/components/productcard.dart';
import 'package:fertilizerapp/models/fertilizer.dart';
import 'package:fertilizerapp/screens/availbelstock.dart';
import 'package:fertilizerapp/screens/fertilizer_restock.dart';
import 'package:fertilizerapp/service/outlet_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

final OutletDatabaseServices outletDatabaseServices = OutletDatabaseServices();

class _HomepageState extends State<Homepage> {
  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Fertilizer'),
          content: FertilizerForm(),
          // content: StreamBuilder(
          //   stream: outletDatabaseServices.getOutlets(),
          //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     List outlets = snapshot.data?.docs ?? [];
              
          //     return PageView.builder(itemBuilder: (context, index) {
          //       // Outlet outlet = outlets[index].data();
          //       String outletID = outlets[index].id;

          //       return Card(child: FertilizerForm(outletId: outletID));
          //     });
          //   },
          // ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Available Stock'),
          actions: [
            ElevatedButton.icon(
              onPressed: () => _showAddDialog(context), // Show dialog on press
              label: Icon(
                Icons.add_circle_rounded,
                color: Colors.black,
                size: 30,
              ),
              style: ButtonStyle(),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: AvailableStockList()));
  }
}
