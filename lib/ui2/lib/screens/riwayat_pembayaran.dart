import 'package:flutter/material.dart';

class RiwayatPembayaran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Pembayaran')),
      body: ListView.builder(
        itemCount: 6,  // Contoh 6 pembayaran terakhir
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Pembayaran SPP Bulan ${index + 1}'),
            subtitle: Text('Tanggal: ${1 + index}/7/2023'),
            trailing: Text('Rp 500.000'),
          );
        },
      ),
    );
  }
}