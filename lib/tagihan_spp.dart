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

  @override
  void initState() {
    super.initState();
    fetchTahunAjaran();
  }

  Future<void> fetchTahunAjaran() async {
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
      throw Exception('Failed to load tahun ajaran');
    }
  }

  Future<void> fetchTagihanSPP(String tahunAjaran) async {
    final response = await http.get(Uri.parse('http://localhost:1233/tagihan-spp/$tahunAjaran'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        tagihanList = data.map((item) => {
          'bulan': item['bulan'],
          'jumlah': item['jumlah_bayar'],
          'status': item['status'] ? 'Lunas' : 'Belum Lunas',
          'tanggal_bayar': item['tgl_bayar'] ?? '-',
        }).toList();
      });
    } else {
      throw Exception('Failed to load tagihan SPP');
    }
  }

  List<Map<String, dynamic>> tagihanList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan SPP'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedTahunAjaran,
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
                    fetchTagihanSPP(newValue); // Fetch tagihan SPP based on selected year
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
                  child: ListTile(
                    title: Text('SPP ${tagihan['bulan']}'),
                    subtitle: Text('Rp ${tagihan['jumlah']}'),
                    trailing: Chip(
                      label: Text(tagihan['status']),
                      backgroundColor: tagihan['status'] == 'Lunas' ? Colors.green : Colors.red,
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