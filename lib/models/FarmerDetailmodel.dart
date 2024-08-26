import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  String firstname;
  String lastname;
  String username;
  int age;
  String district;
  String address;
  String nic;
  String email;
  int phonenum;
  String passsword;

  String vegetable;
  int garea;
  int honetime;
  String season;
  int price1kg;
  int profit1kg;

  Farmer({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.age,
    required this.district,
    required this.address,
    required this.nic,
    required this.email,
    required this.phonenum,
    required this.passsword,
    required this.vegetable,
    required this.garea,
    required this.honetime,
    required this.season,
    required this.price1kg,
    required this.profit1kg,
  });

  // Method to convert Farmer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'age': age,
      'district': district,
      'address': address,
      'nic': nic,
      'mail': email,
      'phonenum': phonenum,
      'password': passsword, // Note: Corrected typo in the field name
      'vegetable': vegetable,
      'garea': garea,
      'harvestOneTime': honetime,
      'season': season,
      'priceP1kg': price1kg,
      'profite1kg': profit1kg,
    };
  }

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['mail'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      district: json['district'] as String? ?? '',
      address: json['address'] as String? ?? '',
      nic: json['nic'] as String? ?? '',
      phonenum: json['phonenum'] as int? ?? 0,
      passsword: json['password'] as String? ?? '',
      vegetable: json['vegetable'] as String? ?? '',
      garea: json['garea'] as int? ?? 0,
      honetime: json['harvestOneTime'] as int? ?? 0,
      season: json['season'] as String? ?? '',
      price1kg: json['priceP1kg'] as int? ?? 0,
      profit1kg: json['profite1kg'] as int? ?? 0,
    );
  }

  Farmer copyWith({
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    int? age,
    String? district,
    String? address,
    String? nic,
    String? passsword,
    int? phonenum,
    String? vegetable,
    int? honetime,
    String? season,
    int? price1kg,
    int? profit1kg,
    int? garea,
  }) {
    return Farmer(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      age: age ?? this.age,
      district: district ?? this.district,
      address: address ?? this.address,
      nic: nic ?? this.nic,
      email: email ?? this.email,
      phonenum: phonenum ?? this.phonenum,
      passsword: passsword ?? this.passsword,
      vegetable: vegetable ?? this.vegetable,
      garea: garea ?? this.garea,
      honetime: honetime ?? this.honetime,
      season: season ?? this.season,
      price1kg: price1kg ?? this.price1kg,
      profit1kg: profit1kg ?? this.profit1kg,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'age': age,
      'district': district,
      'address': address,
      'nic': nic,
      'mail': email,
      'phonenum': phonenum,
      'passsword': passsword,
      'vegetable': vegetable,
      'garea': garea,
      'harvestOneTime': honetime,
      'season': season,
      'priceP1kg': price1kg,
      'profite1kg': profit1kg,
    };
  }
}
