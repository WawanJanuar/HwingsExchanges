import 'package:flutter/material.dart';
import 'package:hwing_exchange/controller/PortoCTRL.dart';
import 'package:hwing_exchange/model/HwingsPort.dart';

class Portofolio extends StatefulWidget {
  const Portofolio({super.key});

  @override
  State<Portofolio> createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> {
  Portoctrl HwingServisPort = Portoctrl();
  late Future<List<Hwingsport>> HwingsMod;

  @override
  void initState() {
    super.initState();
    HwingsMod = HwingServisPort.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("My Wallet", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF0A0F29), Color(0xFF4B0082)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // Kartu Saldo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      49,
                      49,
                      108,
                    ), // Changed this line
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurpleAccent.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 30,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    // Removed the LinearGradient from here
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Estimated Assets Valueas",
                        style: TextStyle(fontSize: 13, color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "\$1.256.019,99",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_circle_down_outlined,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "(-1%) - \$246.029",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Daftar Aset
                Expanded(
                  child: FutureBuilder<List<Hwingsport>>(
                    future: HwingsMod,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: \${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Tidak ada data'));
                      } else {
                        List<Hwingsport> data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];

                            double quantity =
                                double.tryParse(item.quantity) ?? 0;
                            double price =
                                double.tryParse(
                                  item.assetPrice.replaceAll(",", ""),
                                ) ??
                                0;
                            double valuation = quantity * price;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 49, 49, 108),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white10,
                                  backgroundImage: NetworkImage(item.images),
                                ),
                                title: Text(
                                  item.assetName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Harga: \$${item.assetPrice}",
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      "Pnl: \$${item.pnl}",
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.quantity,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "\$${valuation}",
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
