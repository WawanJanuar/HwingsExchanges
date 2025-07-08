// import 'package:cloud_firestore/cloud_firestore.dart';

// class FutureItem {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime? timestamp;

//   FutureItem({
//     required this.id,
//     required this.title,
//     required this.description,
//     this.timestamp,
//   });

//   factory FutureItem.fromJson(Map<String, dynamic> json) {
//     return FutureItem(
//       id: json['id'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'timestamp': timestamp,
//     };
//   }
// }
class FutureOrder {
  final String id;
  final double entryPrice;
  final double quantity;
  final String type; // long / short
  final DateTime timestamp;

  FutureOrder({
    required this.id,
    required this.entryPrice,
    required this.quantity,
    required this.type,
    required this.timestamp,
  });

  factory FutureOrder.fromJson(Map<String, dynamic> json, String id) {
    return FutureOrder(
      id: id,
      entryPrice: json['entryPrice']?.toDouble() ?? 0,
      quantity: json['quantity']?.toDouble() ?? 0,
      type: json['type'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entryPrice': entryPrice,
      'quantity': quantity,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
