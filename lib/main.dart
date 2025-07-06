import 'package:flutter/material.dart';
import 'package:hwing_exchange/controller/providerData.dart';
import 'package:hwing_exchange/model/marketmodel.dart';
import 'package:hwing_exchange/screen/Portofolio.dart';
import 'package:hwing_exchange/screen/future.dart';
import 'package:hwing_exchange/screen/homePage-2.dart';
import 'package:hwing_exchange/screen/marketview.dart';
import 'package:hwing_exchange/screen/tradeview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TokenProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF0F0C1B),
        useMaterial3: true,
      ),
      home: const RootNavigation(),
    );
  }
}

class RootNavigation extends StatefulWidget {
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
    const Tugas3(),
    TradeView(
      coin: Marketmodel(
        id: '1',
        asset_Name: 'BTC',
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png",
        price: 67200.5,
        volume24h: '54000000000',
        changePercent: 2.34,
      ),
    ),
    const FuturePage(),
    const Portofolio(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      extendBody: true, // Tambahkan ini untuk background menyatu
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 49, 49, 108),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              // --- START OF CHANGES ---
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.7),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
              // --- END OF CHANGES ---
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Market',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.swap_horiz),
                  label: 'Perdagangan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.swap_vert_circle_outlined),
                  label: 'Future',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Dompet',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
