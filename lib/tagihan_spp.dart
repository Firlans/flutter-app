import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
            if (tagihan['status'] == 'Belum Lunas')
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
