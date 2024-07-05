import 'package:flutter/material.dart';
import 'profil_siswa.dart';
import 'tagihan_spp.dart';
import 'tagihan_lain.dart';
import 'riwayat_pembayaran.dart';

class DashboardSiswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard Siswa',
          style: TextStyle(
            color: Colors.white, // Adjust app bar text color for better contrast
          ),
        ),
        backgroundColor: Colors.blue, // Set a visually appealing app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white), // Consistent color scheme
            onPressed: () {
              // Implementasi logout
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Consistent padding for aesthetics
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: <Widget>[
            _buildDashboardItem(
              context,
              title: 'Profil',
              icon: Icons.person,
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilSiswa()),
              ),
            ),
            _buildDashboardItem(
              context,
              title: 'Tagihan SPP',
              icon: Icons.receipt_long,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TagihanSPP()),
              ),
            ),
            _buildDashboardItem(
              context,
              title: 'Tagihan Lain',
              icon: Icons.account_balance_wallet,
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TagihanLain()),
              ),
            ),
            _buildDashboardItem(
              context,
              title: 'Riwayat Pembayaran',
              icon: Icons.history,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiwayatPembayaran()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(BuildContext context,
      {required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Consistent padding for spacing
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50.0,
                color: color,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Consider a darker text color for better contrast
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}