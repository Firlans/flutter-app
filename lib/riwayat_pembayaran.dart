import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatPembayaran extends StatefulWidget {
  @override
  _RiwayatPembayaranState createState() => _RiwayatPembayaranState();
}

class _RiwayatPembayaranState extends State<RiwayatPembayaran> {
  // Data dummy untuk contoh
  List<Map<String, dynamic>> riwayatList = [
    {'tanggal': '2023-07-05', 'jenis': 'SPP', 'jumlah': 500000, 'metode': 'Transfer Bank'},
    {'tanggal': '2023-08-03', 'jenis': 'SPP', 'jumlah': 500000, 'metode': 'Tunai'},
    {'tanggal': '2023-09-01', 'jenis': 'Uang Buku', 'jumlah': 250000, 'metode': 'Transfer Bank'},
    {'tanggal': '2023-10-02', 'jenis': 'SPP', 'jumlah': 500000, 'metode': 'E-Wallet'},
    // Tambahkan data riwayat pembayaran lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pembayaran'),
      ),
      body: ListView.builder(
        itemCount: riwayatList.length,
        itemBuilder: (context, index) {
          final riwayat = riwayatList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text('${riwayat['jenis']} - ${_formatDate(riwayat['tanggal'])}'),
              subtitle: Text('Metode: ${riwayat['metode']}'),
              trailing: Text(
                'Rp ${_formatCurrency(riwayat['jumlah'])}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                _showRiwayatDetail(riwayat);
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('dd MMMM yyyy').format(date);
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  void _showRiwayatDetail(Map<String, dynamic> riwayat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Pembayaran'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tanggal: ${_formatDate(riwayat['tanggal'])}'),
              Text('Jenis Pembayaran: ${riwayat['jenis']}'),
              Text('Jumlah: Rp ${_formatCurrency(riwayat['jumlah'])}'),
              Text('Metode Pembayaran: ${riwayat['metode']}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Cetak Bukti'),
              onPressed: () {
                // TODO: Implementasi cetak bukti pembayaran
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}