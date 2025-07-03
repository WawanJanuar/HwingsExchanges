import 'package:flutter/material.dart';
import 'package:hwing_exchange/controller/providerData.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TokenProvider>(context, listen: false).loadTokenData();
    });
  }

  Widget tokenRow({
    required String title,
    required String subtitle,
    required String price,
    required String percentage,
    Color iconColor = Colors.grey,
    Color percentColor = Colors.red,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kiri: Icon + Nama Token
          Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: iconColor),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.white60),
                  ),
                ],
              ),
            ],
          ),

          // Kanan: Harga + Perubahan
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                percentage,
                style: TextStyle(color: percentColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF160B35),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF2C225C),
                      child: const Text(
                        'V',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        'Wawan Januar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFF2C225C),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color(0xFF2C225C),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Asset Value
                const Text(
                  'Estimated Asset Value',
                  style: TextStyle(fontSize: 12, color: Colors.white60),
                ),
                const SizedBox(height: 5),
                const Text(
                  "\$ 1.256.019,99",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // Wrap
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(3, (index) {
                    return SizedBox(
                      width: 148,
                      height: 148,
                      child: Card(
                        elevation: 4,
                        color: Color(0xFF2C225C),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'BTC/USDT',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '\$ 65,432.10',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '+ 0.19%',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.green.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Jelajahi Token Section
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xFF2C225C),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.13),
                        spreadRadius: 1,
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jelajahi Token',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Token Grid
                      Consumer<TokenProvider>(
                        builder: (context, provider, _) {
                          final tokens =
                              provider.trendingTokens.take(5).toList();

                          if (tokens.isEmpty) {
                            return const Text(
                              "Belum ada data token",
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tokens.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemBuilder: (context, index) {
                              final token = tokens[index];
                              final isUp = token.changingPrecentage.contains(
                                '+',
                              );

                              return Card(
                                elevation: 4,
                                color: Color(0xFF160B35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        token.assetName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        token.price,
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        token.changingPrecentage,
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w300,
                                          color:
                                              isUp
                                                  ? Colors.green.shade400
                                                  : Colors.red.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Lihat Lebih Banyak button
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(42),
                          side: BorderSide(color: Colors.white38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Lihat Lebih Banyak",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
