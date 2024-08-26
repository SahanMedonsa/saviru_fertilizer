import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  final String farmerId;
  final String farmerName;

  const BillingScreen({super.key, required this.farmerId, required this.farmerName});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}


class _BillingScreenState extends State<BillingScreen> {
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = 'One'; // Initialize dropdown with the first item in the list
 

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  double _calculatedTotal = 0.0;

    String selectedGrade = 'A';

  void _showAddFertilizerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Fertilizer for ${widget.farmerName}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown for selecting fertilizer type
                // DropdownButton<String>(
                //   value: dropdownValue,
                //   icon: const Icon(Icons.arrow_downward),
                //   elevation: 16,
                //   style: const TextStyle(color: Colors.deepPurple),
                //   underline: Container(
                //     height: 2,
                //     color: Colors.deepPurpleAccent,
                //   ),
                //   onChanged: (String? value) {
                //     // Called when the user selects an item.
                //     setState(() {
                //       dropdownValue = value!; // Update the dropdownValue
                //     });
                //   },
                //   items: list.map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                 DropdownButtonFormField<String>(
                      value: selectedGrade,
                      items: ['A', 'B', 'C']
                          .map((grade) => DropdownMenuItem(
                                value: grade,
                                child: Text(grade),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGrade = value!;
                        
                        });
                      },),
                SizedBox(height: 10),
                // Display selected fertilizer type
                Text(
                  'Selected Fertilizer: $dropdownValue',
                ),
                SizedBox(height: 10),
                // Text field for amount
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                // Text field for price
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                // Display calculated total
                Text('Total: \$${_calculatedTotal.toStringAsFixed(2)}'),
              ],
            ),
          ),
          actions: [
            // Calculate total action
            TextButton(
              onPressed: () {
                double amount = double.tryParse(_amountController.text) ?? 0.0;
                double price = double.tryParse(_priceController.text) ?? 0.0;
                setState(() {
                  _calculatedTotal = amount * price;
                });
              },
              child: Text('Calculate Total'),
            ),
            TextButton(
              onPressed: () {
                // Clear all input fields and selections
                setState(() {
                  dropdownValue = 'One'; // Reset dropdown value to default
                  _amountController.clear();
                  _priceController.clear();
                  _calculatedTotal = 0.0;
                });
                Navigator.of(context).pop();  // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed to the screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final id = args['id'];
    final name = args['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Collection',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddFertilizerDialog,
                  label: Icon(Icons.add),
                  style: ButtonStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
