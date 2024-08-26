import 'package:fertilizerapp/components/textfiels.dart';
import 'package:flutter/material.dart';


class FertilizerForm extends StatefulWidget {
  @override
  _FertilizerFormState createState() => _FertilizerFormState();
}

class _FertilizerFormState extends State<FertilizerForm> {
  final _formKey = GlobalKey<FormState>();
  final _fertilizerController = TextEditingController();
  final _dolomiteController = TextEditingController();
  final _kieController = TextEditingController();
  final _mopController = TextEditingController();
  final _tspController = TextEditingController();
  final _vegetableFertilizerController = TextEditingController();

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
          child: ListView(
            children: [
              Textfields(
                keyboardType: TextInputType.text,
                label: "Fertilizer",
                tcontroller: _fertilizerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a fertilizer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "DOLOMITE",
                tcontroller: _dolomiteController,
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "KIE",
                tcontroller: _kieController,
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "MOP",
                tcontroller: _mopController,
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "TSP",
                tcontroller: _tspController,
              ),
              SizedBox(height: 16),
              Textfields(
                keyboardType: TextInputType.text,
                label: "Vegetable Fertilizer",
                tcontroller: _vegetableFertilizerController,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
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

