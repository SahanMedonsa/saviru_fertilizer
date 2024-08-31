import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableStock {
  int dolomite;
  int kie;
  int mop;
  int tsp;
  int vegetableFertilizer;

  AvailableStock({
    required this.dolomite,
    required this.kie,
    required this.mop,
    required this.tsp,
    required this.vegetableFertilizer,
  });

  factory AvailableStock.fromJson(Map<String, dynamic> json) {
    return AvailableStock(
      dolomite: json['dolomite'] as int? ?? 0,
      kie: json['kie'] as int? ?? 0,
      mop: json['mop'] as int? ?? 0,
      tsp: json['tsp'] as int? ?? 0,
      vegetableFertilizer: json['veg_fert'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dolomite': dolomite,
      'kie': kie,
      'mop': mop,
      'tsp': tsp,
      'veg_fert': vegetableFertilizer,
    };
  }
}
