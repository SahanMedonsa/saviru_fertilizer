import 'package:flutter/material.dart';

class Textfields extends StatelessWidget {
  final String label;
  final Icon? icon;
  final TextEditingController tcontroller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const Textfields({
    Key? key,
    required this.keyboardType,
    required this.label,
    this.icon,
    required this.tcontroller,
    this.validator,
  }) : super(key: key); // Pass key to super constructor

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: validator,
      controller: tcontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: label, // Use labelText instead of label
    
        // Assuming TextStyles.smallText is defined
        prefixIcon: icon,
      ),
    );
  }
}
