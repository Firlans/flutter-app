import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HalamanPembayaran extends StatefulWidget {
  final Map<String, dynamic> tagihan;

  HalamanPembayaran({required this.tagihan});

  @override
  _HalamanPembayaranState createState() => _HalamanPembayaranState();
}

class _HalamanPembayaranState extends State<HalamanPembayaran> {
  String selectedMetode = 'Transfer Bank';
  List<String> metodePembayaran = ['Transfer Bank', 'E-Wallet', 'Tunai'];
  TextEditingController nomorReferensiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Tagihan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildDetailItem('Jenis Tagihan', widget.tagihan['jenis']),
            _buildDetailItem('Bulan', widget.tagihan['bulan']),
            _buildDetailItem('Jumlah', 'Rp ${_formatCurrency(widget.tagihan['jumlah'])}'),
            SizedBox(height: 24),
            Text(
              'Metode Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedMetode,
              isExpanded: true,
              items: metodePembayaran.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedMetode = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: nomorReferensiController,
              decoration: InputDecoration(
                labelText: 'Nomor Referensi Pembayaran',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Bayar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                _prosesPembayaran();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  void _prosesPembayaran() {
    // TODO: Implementasi proses pembayaran sesuai dengan metode yang dipilih
    if (nomorReferensiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon masukkan nomor referensi pembayaran')),
      );
      return;
    }

    // Simulasi proses pembayaran
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text('Apakah Anda yakin ingin melakukan pembayaran?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Ya, Bayar'),
              onPressed: () {
                Navigator.of(context).pop();
                _showPembayaranBerhasil();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPembayaranBerhasil() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran Berhasil'),
          content: Text('Terima kasih, pembayaran Anda telah berhasil diproses.'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
            ),
          ],
        );
      },
    );
  }
}