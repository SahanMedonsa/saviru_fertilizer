
class Outlet {
  String outletname;
  String district;
  num URIA;
  num TSP;
  num MOP;
  num KIE;
  num DOLOMITE;
  num SOA;
  String phone;
  String manager;

  Outlet({
    required this.outletname,
    required this.district,
    required this.URIA,
    required this.TSP,
    required this.MOP,
    required this.KIE,
    required this.DOLOMITE,
    required this.SOA,
    required this.phone,
    required this.manager,
  });

  Outlet.fromJson(Map<String, Object?> json)
      : this(
          outletname: json['outletname']! as String? ?? '',
          district: json['district'] as String? ?? '',
          URIA: json['URIA'] as num? ?? 0,
          TSP: json['TSP'] as num? ?? 0,
          MOP: json['MOP'] as num? ?? 0,
          KIE: json['KIE'] as num? ?? 0,
          DOLOMITE: json['DOLOMITE'] as num? ?? 0,
          SOA: json['SOA'] as num? ?? 0,
          phone: json['phone'] as String? ?? '',
          manager: json['manager'] as String? ?? '',
        );

  Outlet copyWith({
    String? outletname,
    String? district,
    num? URIA,
    num? TSP,
    num? MOP,
    num? KIE,
    num? DOLOMITE,
    num? SOA,
    String? phone,
    String? manager,
  }) {
    return Outlet(
      outletname: outletname ?? this.outletname,
      district: district ?? this.district,
      URIA: URIA ?? this.URIA,
      TSP: TSP ?? this.TSP,
      MOP: MOP ?? this.MOP,
      KIE: KIE ?? this.KIE,
      DOLOMITE: DOLOMITE ?? this.DOLOMITE,
      SOA: SOA ?? this.SOA,
      phone: phone ?? this.phone,
      manager: manager ?? this.manager,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'outletname': outletname,
      'district': district,
      'URIA': URIA,
      'TSP': TSP,
      'MOP': MOP,
      'KIE': KIE,
      'DOLOMITE': DOLOMITE,
      'SOA': SOA,
      'phone': phone,
      'manager': manager,
    };
  }
}
