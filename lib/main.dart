import 'package:client3/komponen_pembayaran_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_siswa.dart';
import 'profil_siswa.dart';
import 'tagihan_spp.dart';
import 'tagihan_lain.dart';
import 'riwayat_pembayaran.dart';
import 'halaman_pembayaran.dart';
import 'manajemen_tahun_ajaran.dart';
import 'komponen_pembayaran_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pembayaran Sekolah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => DashboardSiswa(),
        '/profile': (context) => ProfilSiswa(),
        '/spp_bills': (context) => TagihanSPP(),
        '/other_bills': (context) => TagihanLain(),
        '/payment_history': (context) => RiwayatPembayaran(),
        // '/payment': (context) => HalamanPembayaran(tagihan: tagihan),
        '/manage_academic_year': (context) => ManajemenTahunAjaran(),
        '/manage_payment_components': (context) => KomponenPembayaranPage(),
      },
    );
  }
}