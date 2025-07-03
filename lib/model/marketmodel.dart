import 'dart:convert';

class Marketmodel {
  String? id;
  String imageUrl;
  String asset_Name;
  String volume24h;
  num price;
  num changePercent;

  Marketmodel({
    this.id,
    required this.imageUrl,
    required this.asset_Name,
    required this.volume24h,
    required this.price,
    required this.changePercent,
  });

  factory Marketmodel.fromJson(Map<String, dynamic> json) {
    return Marketmodel(
      id: json["id"],
      imageUrl: json["imageUrl"],
      asset_Name: json["asset_Name"],
      volume24h: json["volume24h"],
      price: json["price"],
      changePercent: json["changePercent"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imageUrl": imageUrl,
      "asset_Name": asset_Name,
      "volume24h": volume24h,
      "price": price,
      "changePercent": changePercent,
    };
  }

  // Untuk SharedPreferences
  factory Marketmodel.fromMap(Map<String, dynamic> map) {
    return Marketmodel(
      id: map['id'],
      imageUrl: map['imageUrl'],
      asset_Name: map['asset_Name'],
      volume24h: map['volume24h'],
      price: map['price'],
      changePercent: map['changePercent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'asset_Name': asset_Name,
      'volume24h': volume24h,
      'price': price,
      'changePercent': changePercent,
    };
  }

  static String encode(List<Marketmodel> coins) =>
      json.encode(coins.map((c) => c.toMap()).toList());

  static List<Marketmodel> decode(String coins) =>
      (json.decode(coins) as List<dynamic>)
          .map<Marketmodel>((item) => Marketmodel.fromMap(item))
          .toList();
}
