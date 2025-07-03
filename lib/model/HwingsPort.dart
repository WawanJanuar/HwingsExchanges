class Hwingsport {
  String id;
  String assetCode;
  String assetName;
  String assetPrice;
  String valuation;
  String pnl;
  String quantity;
  String images;

  Hwingsport({
    required this.id,
    required this.assetCode,
    required this.assetName,
    required this.assetPrice,
    required this.valuation,
    required this.pnl,
    required this.quantity,
    required this.images,
  });

  factory Hwingsport.fromJson(Map<String, dynamic> object) {
    return Hwingsport(
      id: object['id'],
      assetCode: object['assetCode'],
      assetName: object['assetName'],
      assetPrice: object['assetPrice'],
      valuation: object['valuation'],
      pnl: object['pnl'],
      quantity: object['quantity'],
      images: object['images'],
    );
  }
}
