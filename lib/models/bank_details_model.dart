BankDetails? bankDetails;

class BankDetails {
  String micr;
  String branch;
  String address;
  String state;
  String contact;
  String upi;
  String rtgs;
  String city;
  String centre;
  String district;
  String neft;
  String imps;
  dynamic swift;
  String iso3166;
  String bank;
  String bankcode;
  String ifsc;

//<editor-fold desc="Data Methods">
  BankDetails({
    required this.micr,
    required this.branch,
    required this.address,
    required this.state,
    required this.contact,
    required this.upi,
    required this.rtgs,
    required this.city,
    required this.centre,
    required this.district,
    required this.neft,
    required this.imps,
    required this.swift,
    required this.iso3166,
    required this.bank,
    required this.bankcode,
    required this.ifsc,
  });

  BankDetails copyWith({
    String? micr,
    String? branch,
    String? address,
    String? state,
    String? contact,
    String? upi,
    String? rtgs,
    String? city,
    String? centre,
    String? district,
    String? neft,
    String? imps,
    dynamic swift,
    String? iso3166,
    String? bank,
    String? bankcode,
    String? ifsc,
  }) {
    return BankDetails(
      micr: micr ?? this.micr,
      branch: branch ?? this.branch,
      address: address ?? this.address,
      state: state ?? this.state,
      contact: contact ?? this.contact,
      upi: upi ?? this.upi,
      rtgs: rtgs ?? this.rtgs,
      city: city ?? this.city,
      centre: centre ?? this.centre,
      district: district ?? this.district,
      neft: neft ?? this.neft,
      imps: imps ?? this.imps,
      swift: swift ?? this.swift,
      iso3166: iso3166 ?? this.iso3166,
      bank: bank ?? this.bank,
      bankcode: bankcode ?? this.bankcode,
      ifsc: ifsc ?? this.ifsc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'MICR': micr,
      'BRANCH': branch,
      'ADDRESS': address,
      'STATE': state,
      'CONTACT': contact,
      'UPI': upi,
      'RTGR': rtgs,
      'CITY': city,
      'CENTRE': centre,
      'DISTRICT': district,
      'NEFT': neft,
      'IMPS': imps,
      'SWIFT': swift,
      'ISO3166': iso3166,
      'BANK': bank,
      'BANKCODE': bankcode,
      'IFSC': ifsc,
    };
  }

  factory BankDetails.fromMap(Map<String, dynamic> map) {
    return BankDetails(
      micr: map['MICR'] as String,
      branch: map['BRANCH'] as String,
      address: map['ADDRESS'] as String,
      state: map['STATE'] as String,
      contact: map['CONTACT'] as String,
      upi: map['UPI'] as String,
      rtgs: map['RTGS'] as String,
      city: map['CITY'] as String,
      centre: map['CENTRE'] as String,
      district: map['DISTRICT'] as String,
      neft: map['NEFT'] as String,
      imps: map['IMPS'] as String,
      swift: map['SWIFT'] as dynamic,
      iso3166: map['ISO3166'] as String,
      bank: map['BANK'] as String,
      bankcode: map['BANKCODE'] ?? "",
      ifsc: map['IFSC'] as String,
    );
  }
}
