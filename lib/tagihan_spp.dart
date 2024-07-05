import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'halaman_pembayaran.dart';

class TagihanSPP extends StatefulWidget {
  @override
  _TagihanSPPState createState() => _TagihanSPPState();
}

class _TagihanSPPState extends State<TagihanSPP> {
  String selectedTahunAjaran = '2023/2024';
  List<String> tahunAjaranList = [];
  List<Map<String, dynamic>> tagihanList = [];

  @override
  void initState() {
    super.initState();
    fetchTahunAjaran();
  }

  Future<void> fetchTahunAjaran() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:1233/tahun-ajaran'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tahunAjaranList = data.map((item) => item['periode'].toString()).toList();
          if (tahunAjaranList.isNotEmpty) {
            selectedTahunAjaran = tahunAjaranList.first;
            fetchTagihanSPP(selectedTahunAjaran); // Fetch tagihan SPP based on default selected year
          }
        });
      } else {
        throw Exception('Failed to load tahun ajaran: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tahun ajaran: $e');
    }
  }

  Future<void> fetchTagihanSPP(String tahunAjaran) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:1233/tagihan/$tahunAjaran'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tagihanList = data.map((item) => {
            'bulan': item['Bulan'],
            'jumlah': item['JumlahBayar'],
            'status': item['Status'],
            'tanggal_bayar': item['TglPembayaran'] ?? '-',
          }).toList();
        });
      } else {
        throw Exception('Failed to load tagihan SPP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tagihan SPP: $e');
    }
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

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/pembayaran_spp.pdf");
    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved at ${file.path}')),
    );
  }

  String _formatDate(String date) {
    // Implement the date formatting logic
    return date;
  }

  String _formatCurrency(String amount) {
    // Implement the currency formatting logic
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan SPP'),
        centerTitle: true,
        backgroundColor: Color(0xFF0066A2),
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Light background color
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                value: selectedTahunAjaran,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                isExpanded: true,
                items: tahunAjaranList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedTahunAjaran = newValue;
                      fetchTagihanSPP(selectedTahunAjaran); // Fetch tagihan SPP based on selected year
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tagihanList.length,
                itemBuilder: (context, index) {
                  final tagihan = tagihanList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('SPP ${tagihan['bulan']}'),
                      subtitle: Text('Rp ${tagihan['jumlah']}'),
                      trailing: Chip(
                        label: Text(tagihan['status']),
                        backgroundColor: tagihan['status'] == 'berhasil' ? Colors.green : Colors.red,
                      ),
                      onTap: () {
                        _showTagihanDetail(tagihan);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagihanDetail(Map<String, dynamic> tagihan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Tagihan SPP'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bulan: ${tagihan['bulan']}'),
              Text('Jumlah: Rp ${tagihan['jumlah']}'),
              Text('Status: ${tagihan['status']}'),
              Text('Tanggal Bayar: ${tagihan['tanggal_bayar']}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (tagihan['status'] == 'gagal')
              ElevatedButton(
                child: Text('Bayar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _navigateToHalamanPembayaran(tagihan);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFFFFF), // Button color
                ),
              ),
            if(tagihan['status'] == 'berhasil')
              ElevatedButton(
                child: Text('Cetak Bukti'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _generatePDF(tagihan);
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

  void _navigateToHalamanPembayaran(Map<String, dynamic> tagihan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanPembayaran(
          tagihan: {
            'jenis': 'SPP',
            'bulan': tagihan['bulan'],
            'jumlah': tagihan['jumlah'],
          },
        ),
      ),
    );
  }
}
