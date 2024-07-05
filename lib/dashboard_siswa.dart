import 'package:flutter/material.dart';
import 'profil_siswa.dart';
import 'tagihan_spp.dart';
import 'tagihan_lain.dart';
import 'riwayat_pembayaran.dart';

class DashboardSiswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0066A2), // Warna latar belakang biru
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildMenuGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile_image.png'), // Ganti dengan path gambar profil
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Divy Jani',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Class 8 | Roll no 1',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: <Widget>[
              _buildMenuItem(
                context,
                icon: Icons.person,
                label: 'Profil',
                color: Colors.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilSiswa()),
                ),
              ),
              _buildMenuItem(
                context,
                icon: Icons.receipt_long,
                label: 'Tagihan SPP',
                color: Colors.green,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TagihanSPP()),
                ),
              ),
              _buildMenuItem(
                context,
                icon: Icons.account_balance_wallet,
                label: 'Tagihan Lain',
                color: Colors.orange,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TagihanLain()),
                ),
              ),
              _buildMenuItem(
                context,
                icon: Icons.history,
                label: 'Riwayat Pembayaran',
                color: Colors.purple,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RiwayatPembayaran()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 40, color: color),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}