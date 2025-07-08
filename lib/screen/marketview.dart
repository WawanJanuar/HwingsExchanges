import 'package:flutter/material.dart';
import 'package:hwing_exchange/controller/marketcontroller.dart';
import 'package:hwing_exchange/model/marketmodel.dart';
import 'package:hwing_exchange/screen/tradeview.dart';

class Tugas3 extends StatefulWidget {
  const Tugas3({super.key});

  @override
  State<Tugas3> createState() => _Tugas3State();
}

class _Tugas3State extends State<Tugas3> {
  final MarketController controller = MarketController();
  List<Marketmodel> allCoins = [];
  int selectedTab = 0;

  final List<String> tabs = ['Tren', 'Kapitalisasi Pasar', 'Gainers', 'Losers'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Ambil dari cache dulu
    final local = await controller.getLocalCoins();
    if (mounted) setState(() => allCoins = local);

    // Ambil dari API, dan update tampilan
    final updated = await controller.fetchAndCacheData();
    if (mounted) setState(() => allCoins = updated);
    // setState(() => allCoins = data);
  }

  void showEditCoinDialog(Marketmodel coin) {
    final nameController = TextEditingController(text: coin.asset_Name);
    final imageUrlController = TextEditingController(text: coin.imageUrl);
    final volumeController = TextEditingController(text: coin.volume24h);
    final priceController = TextEditingController(text: coin.price.toString());
    final changePercentController = TextEditingController(
      text: coin.changePercent.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C225C),
          title: const Text("Edit Coin", style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildDialogTextField("Nama Coin", nameController),
                _buildDialogTextField("URL Gambar", imageUrlController),
                _buildDialogTextField("Volume 24h", volumeController),
                _buildDialogTextField("Harga", priceController),
                _buildDialogTextField("Perubahan (%)", changePercentController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Batal",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  coin.asset_Name = nameController.text;
                  coin.imageUrl = imageUrlController.text;
                  coin.volume24h = volumeController.text;
                  coin.price = double.parse(priceController.text);
                  coin.changePercent = double.parse(
                    changePercentController.text,
                  );

                  await controller.updateCoin(coin);
                  _loadData();
                  Navigator.pop(context);
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Format input salah.")),
                  );
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
      ),
    );
  }

  Widget buildCoinCard(Marketmodel data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TradeView(coin: data)),
        );
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Card(
            color: const Color(0xFF2C225C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data.imageUrl),
                    radius: 20,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text(
                      data.asset_Name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _formatVolume(data.volume24h),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${data.price.toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          "${data.changePercent.toStringAsFixed(2)}%",
                          style: TextStyle(
                            color:
                                data.changePercent >= 0
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orangeAccent),
                    onPressed: () => showEditCoinDialog(data),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () async {
                      if (data.id != null) {
                        await controller.deleteCoin(data.id!);
                        _loadData();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatVolume(String volume) {
    try {
      final v = double.parse(volume);
      if (v >= 1_000_000_000)
        return "${(v / 1_000_000_000).toStringAsFixed(1)}B";
      if (v >= 1_000_000) return "${(v / 1_000_000).toStringAsFixed(1)}M";
      if (v >= 1_000) return "${(v / 1_000).toStringAsFixed(1)}K";
      return v.toStringAsFixed(0);
    } catch (_) {
      return volume;
    }
  }

  double _calculateMarketCap(Marketmodel coin) {
    final price = double.tryParse(coin.price.toString()) ?? 0;
    final volume = double.tryParse(coin.volume24h) ?? 0;
    return price * volume;
  }

  Widget buildTabs() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final isActive = selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => selectedTab = index),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration:
                  isActive
                      ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.cyanAccent,
                            width: 2,
                          ),
                        ),
                      )
                      : null,
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isActive ? Colors.cyanAccent : Colors.white54,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody() {
    List<Marketmodel> filteredData = [...allCoins];
    switch (selectedTab) {
      case 1:
        filteredData.sort(
          (a, b) => _calculateMarketCap(b).compareTo(_calculateMarketCap(a)),
        );
        break;
      case 2:
        filteredData.sort((a, b) => b.changePercent.compareTo(a.changePercent));
        break;
      case 3:
        filteredData.sort((a, b) => a.changePercent.compareTo(b.changePercent));
        break;
    }

    return Column(
      children: [
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 5),
          child: Text(
            'Peringkat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        buildTabs(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) => buildCoinCard(filteredData[index]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF160B35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF160B35),
        toolbarHeight: 90,
        title: TextField(
          onChanged: (value) async {
            final coins = await controller.fetchAndCacheData();
            setState(() {
              allCoins =
                  coins
                      .where(
                        (coin) => coin.asset_Name.toLowerCase().contains(
                          value.toLowerCase(),
                        ),
                      )
                      .toList();
            });
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            hintText: 'Search...',
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: const Color(0xFF2C225C),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
        ),
      ),
      body: buildBody(),
    );
  }
}
