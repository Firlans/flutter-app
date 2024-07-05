import 'package:flutter/material.dart';
import 'screens/siswa_screen.dart';
import 'screens/transaksi_screen.dart';
import 'screens/pembayaran_screen.dart';
import 'screens/tagihan_spp_screen.dart';
import 'screens/komponen_screen.dart';
import 'screens/tagihan_lain_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SiswaScreen(),
    TransaksiScreen(),
    PembayaranScreen(),
    TagihanSPPScreen(),
    KomponenScreen(),
    TagihanLainScreen(),
  ];

  final List<String> _titles = [
    'Siswa',
    'Transaksi',
    'Pembayaran',
    'Tagihan SPP',
    'Komponen',
    'Tagihan Lain',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Siswa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Tagihan SPP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: 'Komponen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Tagihan Lain',
          ),
        ],
      ),
    );
  }
}
