import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/marketmodel.dart';

class MarketController {
  final Dio dio = Dio();
  final String baseUrl =
      'https://68482640ec44b9f3493fcfd3.mockapi.io/api/v1/coinsdata';
  final String localKey = 'cachedCoins';

  /// Ambil data dari SharedPreferences (local cache)
  Future<List<Marketmodel>> getLocalCoins() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(localKey);
    if (json != null) {
      return Marketmodel.decode(json);
    }
    return [];
  }

  /// Simpan data ke SharedPreferences (cache)
  Future<void> saveToLocal(List<Marketmodel> coins) async {
    final prefs = await SharedPreferences.getInstance();
    final json = Marketmodel.encode(coins);
    await prefs.setString(localKey, json);
  }

  /// Ambil data dari API dan simpan ke local
  Future<List<Marketmodel>> fetchAndCacheData() async {
    try {
      final response = await dio.get('$baseUrl');
      if (response.statusCode == 200 && response.data is List) {
        final coins =
            (response.data as List)
                .map((e) => Marketmodel.fromJson(e))
                .toList();
        await saveToLocal(coins);
        return coins;
      }
    } catch (e) {
      print('Gagal fetch dari API: $e');
    }

    // Fallback ke lokal jika gagal fetch API
    return await getLocalCoins();
  }

  Future<void> addCoin(Marketmodel coin) async {
    try {
      coin.id = const Uuid().v4();
      final response = await dio.post('$baseUrl', data: coin.toJson());
      if (response.statusCode == 201) {
        final current = await fetchAndCacheData();
        await saveToLocal(current);
      }
    } catch (e) {
      print('Gagal addCoin: $e');
    }
  }

  Future<void> updateCoin(Marketmodel coin) async {
    try {
      if (coin.id == null) return;
      final response = await dio.put(
        '$baseUrl/${coin.id}',
        data: coin.toJson(),
      );
      if (response.statusCode == 200) {
        final current = await fetchAndCacheData();
        await saveToLocal(current);
      }
    } catch (e) {
      print('Gagal updateCoin: $e');
    }
  }

  Future<void> deleteCoin(String id) async {
    try {
      final response = await dio.delete('$baseUrl/$id');
      if (response.statusCode == 200) {
        final current = await fetchAndCacheData();
        await saveToLocal(current);
      }
    } catch (e) {
      print('Gagal deleteCoin: $e');
    }
  }
}
