import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
        centerTitle: true,
        backgroundColor: Color(0xFF0066A2),
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Light background color
        child: ListView.builder(
          itemCount: riwayatList.length,
          itemBuilder: (context, index) {
            final riwayat = riwayatList[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                Navigator.of(context).pop();
                _generatePDF(riwayat);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFFFFF), // Button color
              ),
            ),
          ],
        );
      },
    );
  }

  void _generatePDF(Map<String, dynamic> riwayat) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Detail Pembayaran', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Tanggal: ${_formatDate(riwayat['tanggal'])}', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Jenis Pembayaran: ${riwayat['jenis']}', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Jumlah: Rp ${_formatCurrency(riwayat['jumlah'])}', style: pw.TextStyle(fontSize: 18)),
                pw.Text('Metode Pembayaran: ${riwayat['metode']}', style: pw.TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
