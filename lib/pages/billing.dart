import 'package:fertilizerapp/components/Gtext.dart';
import 'package:fertilizerapp/service/farmer_db_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillingScreen extends StatefulWidget {
  final String farmerId;
  final String farmerName;

  const BillingScreen({super.key, required this.farmerId, required this.farmerName});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  double _calculatedTotal = 0.0;
  String? selectedfertilizer;
  List<Map<String, dynamic>> savedCollections = [];

  final FarmerDatabaseServices farmerDatabaseServices = FarmerDatabaseServices();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetchSavedCollections(); // Fetch data on initialization
  }

  void _showAlertDialog(String message, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Success' : 'Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clear() {
    _amountController.clear();
    _priceController.clear();
    _dateController.clear();
    selectedfertilizer = null;
    _calculatedTotal = 0.0;
  }

  Future<void> _fetchSavedCollections() async {
    try {
      final collections = await farmerDatabaseServices.getFertilizerBills(widget.farmerId);
      setState(() {
        savedCollections = collections;
      });
    } catch (e) {
      print("Error fetching collections: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _calculateTotal() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    double price = double.tryParse(_priceController.text) ?? 0.0;
    setState(() {
      _calculatedTotal = amount * price;
    });
  }
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
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  hint: Text("select fertilizer"),
                  value: selectedfertilizer,
                  items: ['A', 'B', 'C']
                      .map((grade) => DropdownMenuItem(
                            value: grade,
                            child: Text(grade),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedfertilizer = value!;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _calculateTotal(),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _calculateTotal(),
                ),
                SizedBox(height: 10),
                Text('Total: \$${_calculatedTotal.toStringAsFixed(2)}'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                try {
                  if (selectedfertilizer == null ||
                      selectedfertilizer!.isEmpty) {
                    _showAlertDialog("Please select a vegetable.", false);
                    return;
                  }
                  // Call the backend function with your form data
                  await farmerDatabaseServices.addFertilizerBill(
                      widget.farmerId,
                      selectedfertilizer!,
                      _priceController.text,
                      _amountController.text,
                      _dateController.text );

                  // Show Snackbar on successful submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully updated!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Clear input fields after successful submission
                  _clear();

                  // Fetch the updated list of saved collections
                  _fetchSavedCollections();

                  // Dismiss the dialog
                  Navigator.of(context).pop();
                } catch (e) {
                  // Show error message if something goes wrong
                  _showAlertDialog("Failed to update: $e", false);
                }
              },
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _amountController.clear();
                  _priceController.clear();
                  _dateController.text =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                  _calculatedTotal = 0.0;
                });
                Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.farmerName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fertilizer Bill',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddFertilizerDialog,
                  icon: Icon(Icons.add),
                  label: Text('Create'),
                ),
              ],
            ),

             Expanded(
              child: ListView.builder(
                itemCount: savedCollections.length,
                itemBuilder: (context, index) {
                  var collection = savedCollections[index];
                  String docId = collection['id'] ??
                      ''; // Assuming you are storing the document ID in the collection

                  return Dismissible(
                    key: Key(docId),
                    direction: DismissDirection
                        .endToStart, // Only swipe from right to left
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      farmerDatabaseServices.deleteDailyCollectionData(
                          widget.farmerId, docId);
                      setState(() {
                        savedCollections
                            .removeAt(index); // Remove from list as well
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Gtext(
                                text: '${collection['purchasedate']}',
                                tsize: 16,
                                tcolor: Colors.black,
                                fweight: FontWeight.bold),
                            Gtext(
                                text:
                                    '${collection['type']} - ${collection['amount']} kg',
                                tsize: 16,
                                tcolor: Colors.black,
                                fweight: FontWeight.w500),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Gtext(
                                text: 'Price: Rs.${collection['price']}',
                                tsize: 16,
                                tcolor: Colors.black,
                                fweight: FontWeight.w500),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
