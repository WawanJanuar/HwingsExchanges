import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hwing_exchange/model/futuremodel.dart'; // import model yang sudah diganti

class FutureController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<FutureItem> _histories = [];

  List<FutureItem> get histories => _histories;

  Future<void> signInAnonymously() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }
  }

  Future<void> fetchHistories() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final snapshot =
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('history')
            .orderBy('timestamp', descending: true)
            .get();

    _histories =
        snapshot.docs.map((doc) => FutureItem.fromJson(doc.data())).toList();
    notifyListeners();
  }

  Future<void> addHistory(FutureItem history) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('users').doc(uid).collection('history').add({
      ...history.toJson(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    await fetchHistories(); // Sinkronisasi ulang
  }
}
