import 'package:flutter/material.dart';

class FuturePage extends StatelessWidget {
  const FuturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D111C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D111C),
        elevation: 0,
        title: const Text(
          'BTCUSDT-PERP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.picture_in_picture_alt_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Perpetual', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 4),
                    Text('-0.84%', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Funding Rate / Countdown',
                      style: TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '0.01% / 03:43:42',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Laverage', style: TextStyle(color: Colors.white)),
                SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '25x',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.info_outline, color: Colors.white54, size: 16),
                SizedBox(width: 8),
                Text('Order Limit', style: TextStyle(color: Colors.white70)),
                Spacer(),
                Icon(Icons.arrow_drop_down, color: Colors.white70),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.remove, color: Colors.white30),
                  Text(
                    '107961',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(Icons.add, color: Colors.white30),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Text('Quantity', style: TextStyle(color: Colors.white54)),
                  Spacer(),
                  Text('BTC', style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_drop_down, color: Colors.white70),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tersedia 0 USDT',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  [0, 25, 50, 75, 100]
                      .map(
                        (e) => Column(
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor:
                                  e == 0 ? Colors.blue : Colors.white,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$e%',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('TP/SL', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Max Open\n0 BTC',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Text(
                  '107960.5',
                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 24),
                ),
                Text(
                  'Max Open\n0 BTC',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Cost\n0 USDT',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Text('108068.2', style: TextStyle(color: Colors.white54)),
                Text(
                  'Cost\n0 USDT',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Open Long\n=0 USDT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Open Short\n=0 USDT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: const [
                        OrderBookItem(
                          price: '108246.1',
                          amount: '0.51',
                          color: Colors.red,
                        ),
                        OrderBookItem(
                          price: '108200',
                          amount: '0.002',
                          color: Colors.red,
                        ),
                        OrderBookItem(
                          price: '108162.9',
                          amount: '0.946',
                          color: Colors.red,
                        ),
                        OrderBookItem(
                          price: '108025.4',
                          amount: '0.352',
                          color: Colors.red,
                        ),
                        OrderBookItem(
                          price: '108025.1',
                          amount: '0.338',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ListView(
                      children: const [
                        OrderBookItem(
                          price: '107960.5',
                          amount: '0.213',
                          color: Colors.lightBlueAccent,
                        ),
                        OrderBookItem(
                          price: '107957.5',
                          amount: '0.376',
                          color: Colors.lightBlueAccent,
                        ),
                        OrderBookItem(
                          price: '107954.8',
                          amount: '0.34',
                          color: Colors.lightBlueAccent,
                        ),
                        OrderBookItem(
                          price: '107946.8',
                          amount: '1.682',
                          color: Colors.lightBlueAccent,
                        ),
                        OrderBookItem(
                          price: '107900',
                          amount: '0.01',
                          color: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderBookItem extends StatelessWidget {
  final String price;
  final String amount;
  final Color color;

  const OrderBookItem({
    required this.price,
    required this.amount,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(price, style: TextStyle(color: color)),
          Text(amount, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
