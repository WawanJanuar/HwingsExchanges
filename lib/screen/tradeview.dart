import 'package:flutter/material.dart';
import 'package:hwing_exchange/model/marketmodel.dart';

class TradeView extends StatefulWidget {
  final Marketmodel? coin;
  const TradeView({super.key, required this.coin});

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  bool isBuySelected = true;
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    return Scaffold(
      backgroundColor: const Color(0xFF160B35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF160B35),
        title: const Text("Perdagangan", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body:
          coin == null
              ? const Center(
                child: Text(
                  'Tidak ada koin dipilih',
                  style: TextStyle(color: Colors.white),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Toggle Button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C225C),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isBuySelected = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isBuySelected
                                          ? Colors.green
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Beli",
                                  style: TextStyle(
                                    color:
                                        isBuySelected
                                            ? Colors.white
                                            : Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap:
                                  () => setState(() => isBuySelected = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      !isBuySelected
                                          ? Colors.red
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Jual",
                                  style: TextStyle(
                                    color:
                                        !isBuySelected
                                            ? Colors.white
                                            : Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Harga Pasar
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            "Harga Pasar",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "Rp41.654.773,25",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Koin Info
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(coin.imageUrl),
                          radius: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          coin.asset_Name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Input jumlah
                    Text(
                      isBuySelected ? "Jumlah Pembelian" : "Jumlah Penjualan",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C225C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(color: Colors.white38),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "IDR",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    Text(
                      "Jumlah IDR: Rp${amountController.text}",
                      style: const TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 20),

                    // Info Minimum Pembelian
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.help_outline,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Min. Pembelian: ETH 0,00002401 / Rp1.000",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: const Color(0xFF2C225C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Lanjutkan"),
                    ),
                  ],
                ),
              ),
    );
  }
}
