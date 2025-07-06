import 'package:cloud_firestore/cloud_firestore.dart';

class FutureItem {
  final String id;
  final String title;
  final String description;
  final DateTime? timestamp;

  FutureItem({
    required this.id,
    required this.title,
    required this.description,
    this.timestamp,
  });

  factory FutureItem.fromJson(Map<String, dynamic> json) {
    return FutureItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp,
    };
  }
}
