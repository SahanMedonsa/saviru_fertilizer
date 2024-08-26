import 'package:fertilizerapp/components/detailstext.dart';
import 'package:fertilizerapp/service/outlet_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Ensure this is a valid path

class FertilizerOutletDetails extends StatefulWidget {
  const FertilizerOutletDetails({Key? key}) : super(key: key);

  @override
  State<FertilizerOutletDetails> createState() =>
      _FertilizerOutletDetailsState();
}

class _FertilizerOutletDetailsState extends State<FertilizerOutletDetails> {
  final _fertilizerDatabase = OutletDatabaseServices();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: AppBar(
title: Text('Outlet Profile'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fertilizer Outlet Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: height,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _fertilizerDatabase.getOutlets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
              
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
              
                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No data found'));
                    }
              
                    // Accessing document fields
                    final outletData = snapshot.data!.docs.first;
                    String address = outletData['address'] ?? '';
                    String district = outletData['district'] ?? '';
                    String manager = outletData['manager'] ?? '';
                    String outletNo = outletData['outletNo'] ?? '';
                    String password = outletData['password'] ?? '';
                    String phoneNum = outletData['phoneNum'] ?? '';
                    String username = outletData['username'] ?? '';
              
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailtext(detail: 'Outlet No', db_datil: outletNo),
                        detailtext(detail: 'Manager', db_datil: manager),
                        detailtext(detail: 'District', db_datil: district),
                        detailtext(detail: 'Address', db_datil: address),
                        detailtext(detail: 'Phone Number', db_datil: phoneNum),
                        detailtext(detail: 'Password', db_datil: password),
                        detailtext(detail: 'Username', db_datil: username),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
