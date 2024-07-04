import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TagihanSiswa extends StatefulWidget {
  @override
  _TagihanSiswaState createState() => _TagihanSiswaState();
}

class _TagihanSiswaState extends State<TagihanSiswa> {
  List<Map<String, dynamic>> tagihanList = [];
  List<String> tahunAjaranList = [];
  String selectedTahunAjaran = '';
  Map<String, dynamic> jsonData = {}; // Deklarasi variabel jsonData

  @override
  void initState() {
    super.initState();
    loadTagihanData();
  }

  Future<void> loadTagihanData() async {
    try {
      final String response = await rootBundle.loadString('../assets/data/tagihan.json');
      jsonData = json.decode(response); // Inisialisasi jsonData dengan hasil decode

      // Ambil daftar tahun ajaran dari keys JSON
      tahunAjaranList = jsonData.keys.toList();

      // Default pilih tahun ajaran pertama
      if (tahunAjaranList.isNotEmpty) {
        selectedTahunAjaran = tahunAjaranList[0];
        tagihanList = List<Map<String, dynamic>>.from(jsonData[selectedTahunAjaran]);
      }

      setState(() {});
    } catch (e) {
      print('Error loading tagihan data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan SPP'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedTahunAjaran,
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
                  tagihanList = List<Map<String, dynamic>>.from(jsonData[newValue]);
                });
              }
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Bulan Tagihan')),
                DataColumn(label: Text('Status Tagihan')),
                DataColumn(label: Text('Jumlah Bayar')),
                DataColumn(label: Text('Tanggal Bayar')),
              ],
              rows: tagihanList.map((item) {
                return DataRow(cells: [
                  DataCell(Text('Bulan ${item['bulan']}')),
                  DataCell(Text(item['status'] == 'Sudah Dibayar' ? 'Lunas' : 'Belum Lunas')),
                  DataCell(Text('Rp ${item['jml_bayar']}')),
                  DataCell(Text(item['tgl_bayar'].toString())),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
