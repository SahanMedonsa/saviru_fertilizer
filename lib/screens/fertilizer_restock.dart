import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fertilizerapp/components/textfiels.dart';
import 'package:fertilizerapp/models/availblestock.dart';
import 'package:fertilizerapp/service/availblestock_service.dart';
import 'package:fertilizerapp/service/outlet_service.dart';
import 'package:flutter/material.dart';

class FertilizerForm extends StatefulWidget {
  // Pass outletId from upstream

  const FertilizerForm({Key? key, }) : super(key: key);

  @override
  _FertilizerFormState createState() => _FertilizerFormState();
}

final FertilizerDatabaseServices fertilizerDatabaseServices = FertilizerDatabaseServices();
final OutletDatabaseServices outletDatabaseServices = OutletDatabaseServices();

class _FertilizerFormState extends State<FertilizerForm> {
  final _formKey = GlobalKey<FormState>();
  final _fertilizerController = TextEditingController();
  final _dolomiteController = TextEditingController();
  final _kieController = TextEditingController();
  final _mopController = TextEditingController();
  final _tspController = TextEditingController();
  final _vegetableFertilizerController = TextEditingController();
  
  String? selectedOutletId; // Variable to track the selected Outlet ID
  
  @override
  void dispose() {
    _fertilizerController.dispose();
    _dolomiteController.dispose();
    _kieController.dispose();
    _mopController.dispose();
    _tspController.dispose();
    _vegetableFertilizerController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (selectedOutletId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an outlet')),
        );
        return;
      }

      AvailableStock stock = AvailableStock(
        dolomite: int.parse(_dolomiteController.text),
        kie: int.parse(_kieController.text),
        mop: int.parse(_mopController.text),
        tsp: int.parse(_tspController.text),
        vegetableFertilizer: int.parse(_vegetableFertilizerController.text),
      );

      // Submit the available stock to the selected outlet
      await fertilizerDatabaseServices.addAvailableStock(selectedOutletId!, stock);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stock added for outlet')),
      );

      // Reset the form and clear the controllers
      _formKey.currentState!.reset();
      _dolomiteController.clear();
      _kieController.clear();
      _mopController.clear();
      _tspController.clear();
      _vegetableFertilizerController.clear();
      setState(() {
        selectedOutletId = null; // Clear selected outlet
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "DOLOMITE",
                tcontroller: _dolomiteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "KIE",
                tcontroller: _kieController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "MOP",
                tcontroller: _mopController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "TSP",
                tcontroller: _tspController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "Vegetable Fertilizer",
                tcontroller: _vegetableFertilizerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Use StreamBuilder to show the list of outlets
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: outletDatabaseServices.getOutlets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List outlets = snapshot.data?.docs ?? [];

                    return ListView.builder(
                      itemCount: outlets.length,
                      itemBuilder: (context, index) {

                        String outletID = outlets[index].id;

                        return ListTile(
                          title: Text("select this button to set branch"),
                          
                          tileColor: Colors.green.withOpacity(0.4),
                          onTap: () {
                            setState(() {
                              selectedOutletId = outletID; // Set selected outlet ID
                            });
                          },
                          selected: selectedOutletId == outletID, // Highlight selected outlet
                          
                          selectedTileColor: Colors.green,
                        );
                      },
                    );
                  },
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _submit, // Call submit method
                    child: Text('Submit'),
                  ),

                   ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  _fertilizerController.clear();
                  _dolomiteController.clear();
                  _kieController.clear();
                  _mopController.clear();
                  _tspController.clear();
                  _vegetableFertilizerController.clear();
                  setState(() {
                    selectedOutletId = null; // Clear selected outlet
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
                ],
              ),
           
             
            ],
          ),
        ),
      ),
    );
  }
}
