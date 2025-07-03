class Datatoken {
  String imageUrl;
  String assetName;
  String subtitle;
  String price;
  String changingPrecentage;

  Datatoken({
    required this.imageUrl,
    required this.assetName,
    required this.subtitle,
    required this.price,
    required this.changingPrecentage,
  });

  factory Datatoken.fromJson(Map<String, dynamic> json) => Datatoken(
    imageUrl: json['imageUrl'],
    assetName: json['assetName'],
    subtitle: json['subtitle'],
    price: json['price'],
    changingPrecentage: json['changingPrecentage'],
  );

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'assetName' : assetName,
    'subtitle' : subtitle,
    'price' : price,
    'changingPrecentage' : changingPrecentage
  };
}