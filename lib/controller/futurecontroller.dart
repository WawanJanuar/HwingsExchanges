// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hwing_exchange/model/futuremodel.dart'; // import model yang sudah diganti

// class FutureController extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   List<FutureItem> _histories = [];

//   List<FutureItem> get histories => _histories;

//   Future<void> signInAnonymously() async {
//     if (_auth.currentUser == null) {
//       await _auth.signInAnonymously();
//     }
//   }

//   Future<void> fetchHistories() async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;

//     final snapshot =
//         await _firestore
//             .collection('users')
//             .doc(uid)
//             .collection('history')
//             .orderBy('timestamp', descending: true)
//             .get();

//     _histories =
//         snapshot.docs.map((doc) => FutureItem.fromJson(doc.data())).toList();
//     notifyListeners();
//   }

//   Future<void> addHistory(FutureItem history) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;

//     await _firestore.collection('users').doc(uid).collection('history').add({
//       ...history.toJson(),
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     await fetchHistories(); // Sinkronisasi ulang
//   }
// }
// provider/futurecontroller.dart

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
