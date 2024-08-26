import 'package:fertilizerapp/components/Gtext.dart';
import 'package:fertilizerapp/components/detailstext.dart';
import 'package:fertilizerapp/components/productcard.dart';
import 'package:fertilizerapp/screens/fertilizer_restock.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Add Fertilizer'), content: FertilizerForm()
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();  // Close the dialog
            //     },
            //     child: Text('Cancel'),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       // Implement your add logic here
            //       Navigator.of(context).pop();  // Close the dialog
            //     },
            //     child: Text('Add'),
            //   ),
            // ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           ProductCard(imagePath: "assets/pngwing.com (2).png", productName: "URIA", stockAmount: "20", pricePerKg: "234.00"),
             ProductCard(imagePath: "assets/pngwing.com (2).png", productName: "URIA", stockAmount: "20", pricePerKg: "234.00")
          ],
        ),
      ),
    );
  }
}
