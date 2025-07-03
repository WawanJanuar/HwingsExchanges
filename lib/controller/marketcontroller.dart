import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../model/marketmodel.dart';

class MarketController {
  final String coinsKey = 'coins';

  /// Ambil semua data dari SharedPreferences
  Future<List<Marketmodel>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCoins = prefs.getString(coinsKey);

    if (storedCoins != null) {
      return Marketmodel.decode(storedCoins);
    } else {
      return [];
    }
  }

  /// Simpan semua data ke SharedPreferences
  Future<void> saveData(List<Marketmodel> coins) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = Marketmodel.encode(coins);
    await prefs.setString(coinsKey, encoded);
  }

  /// Tambah koin baru ke SharedPreferences
  Future<void> addCoin(Marketmodel coin) async {
    final coins = await fetchData();
    coin.id = Uuid().v4();
    coins.add(coin);
    await saveData(coins);
  }

  /// Update data koin berdasarkan ID
  Future<void> updateCoin(Marketmodel coin) async {
    final coins = await fetchData();
    final index = coins.indexWhere((c) => c.id == coin.id);
    if (index != -1) {
      coins[index] = coin;
      await saveData(coins);
    }
  }

  /// Hapus koin berdasarkan ID
  Future<void> deleteCoin(String id) async {
    final coins = await fetchData();
    coins.removeWhere((c) => c.id == id);
    await saveData(coins);
  }

  /// Tambahkan 10 data awal jika belum ada di SharedPreferences
  Future<void> initializeDefaultDataIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCoins = prefs.getString(coinsKey);

    if (storedCoins == null) {
      final List<Marketmodel> defaultCoins = [
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "BTC",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png",
          price: 67200.5,
          volume24h: "54B",
          changePercent: 2.34,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "ETH",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png",
          price: 3520.75,
          volume24h: "24B",
          changePercent: -1.12,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "SOL",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/b/b9/Solana_logo.png",
          price: 155.6,
          volume24h: "6.8B",
          changePercent: 4.9,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "BNB",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/BNB%2C_native_cryptocurrency_for_the_Binance_Smart_Chain.svg/250px-BNB%2C_native_cryptocurrency_for_the_Binance_Smart_Chain.svg.png",
          price: 610.4,
          volume24h: "3.2B",
          changePercent: 0.85,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "XRP",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/2/29/Xrp-symbol-black-128.png",
          price: 0.68,
          volume24h: "1.9B",
          changePercent: -0.75,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "ADA",
          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc_CR1xP2WvE8vbPKTs5xYgjYB8RYLMlwF1A&s",
          price: 0.44,
          volume24h: "1.1B",
          changePercent: 1.42,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "DOGE",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/d/d0/Dogecoin_Logo.png",
          price: 0.14,
          volume24h: "800M",
          changePercent: 3.65,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "AVAX",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/0/03/Avalanche_logo_without_text.png",
          price: 35.22,
          volume24h: "620M",
          changePercent: 0.44,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "DOT",
          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOIi7O4wSHBDfgShQvylDlWRSO9gkyuwFeRkvqsveA45Jk1YeD3bYX3wNlpQQD1yRsS58&usqp=CAU",
          price: 6.12,
          volume24h: "550M",
          changePercent: -2.2,
        ),
        Marketmodel(
          id: Uuid().v4(),
          asset_Name: "MATIC",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Polygon_Icon.svg/1200px-Polygon_Icon.svg.png",
          price: 0.87,
          volume24h: "740M",
          changePercent: -0.66,
        ),
      ];

      final encoded = Marketmodel.encode(defaultCoins);
      await prefs.setString(coinsKey, encoded);
    }
  }
}
