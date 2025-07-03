import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hwing_exchange/model/classData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  List<Datatoken> _tokens = [];

  List<Datatoken> get tokens => _tokens;

  TokenProvider() {
    loadTokenData();
  }

  List<Datatoken> get trendingTokens {
    return _tokens.where((token) {
      return token.changingPrecentage.contains('+');
    }).toList();
  }

  Future<void> loadTokenData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('tokenData');
    if (jsonString != null) {
      final List jsonData = jsonDecode(jsonString);
      _tokens = jsonData.map((e) => Datatoken.fromJson(e)).toList();
    }
    notifyListeners();
  }

  Future<void> saveTokenData(List<Datatoken> tokens) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tokens.map((e) => e.toJson()).toList();
    await prefs.setString('tokenData', jsonEncode(jsonList));
    _tokens = tokens;
    notifyListeners();
  }
}
