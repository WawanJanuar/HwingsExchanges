import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/futuremodel.dart';

class FutureController extends ChangeNotifier {
  final TextEditingController entryPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<FutureOrder> _orders = [];
  List<FutureOrder> get orders => _orders;

  Future<void> init() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
      print(_auth.signInAnonymously());
    }
    await fetchOrders();
  }

  Future<void> placeOrder(String type) async {
    try {
      double entryPrice = double.parse(entryPriceController.text);
      double quantity = double.parse(quantityController.text);

      DocumentReference doc = await _firestore.collection('orders').add({
        'entryPrice': entryPrice,
        'quantity': quantity,
        'type': type,
        'timestamp': DateTime.now().toIso8601String(),
      });

      _orders.add(
        FutureOrder(
          id: doc.id,
          entryPrice: entryPrice,
          quantity: quantity,
          type: type,
          timestamp: DateTime.now(),
        ),
      );

      notifyListeners();
    } catch (e) {
      debugPrint("Error placing order: $e");
    }
  }

  Future<void> fetchOrders() async {
    try {
      final snapshot =
          await _firestore
              .collection('orders')
              .orderBy('timestamp', descending: true)
              .get();

      _orders =
          snapshot.docs
              .map((doc) => FutureOrder.fromJson(doc.data(), doc.id))
              .toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching orders: $e");
    }
  }
}
