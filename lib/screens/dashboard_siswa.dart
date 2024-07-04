import 'package:flutter/material.dart';
import 'profil_siswa.dart';
import 'tagihan_siswa.dart';
import 'riwayat_pembayaran.dart';

class DashboardSiswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Siswa')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: <Widget>[
          DashboardItem(
            title: 'Profil',
            icon: Icons.person,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilSiswa()),
            ),
          ),
          DashboardItem(
            title: 'Tagihan',
            icon: Icons.receipt_long,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TagihanSiswa()),
            ),
          ),
          DashboardItem(
            title: 'Riwayat Pembayaran',
            icon: Icons.history,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiwayatPembayaran()),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardItem({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 36.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
