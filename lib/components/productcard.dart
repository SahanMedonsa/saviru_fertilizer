import 'package:fertilizerapp/components/Gtext.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;   // Image path parameter
  final String productName;  // Product name
  final String stockAmount;  // Stock amount
  final String pricePerKg;   // Price per kg

  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.stockAmount,
    required this.pricePerKg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get the screen width
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: width,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 20, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width * 1 / 5,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath), // Use imagePath parameter
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Gtextfd(text: "Name : "),
                          Gtextfd(text: productName),
                        ],
                      ),
                      Row(
                        children: [
                          Gtextfd(text: "Astock (kg): "),
                          Gtextfd(text: stockAmount), 
                        ],
                      ),
                      Row(
                        children: [
                          Gtextfd(text: "Price (1kg) : "),
                           Gtextfd(text: pricePerKg), 
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       // Use productName parameter
                       // Use stockAmount parameter
                        // Use pricePerKg parameter
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
