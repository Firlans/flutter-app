import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TagihanSiswa extends StatefulWidget {
  @override
  _TagihanSiswaState createState() => _TagihanSiswaState();
}

class _TagihanSiswaState extends State<TagihanSiswa> {
  List<Map<String, dynamic>> tagihanList = [];

  @override
  void initState() {
    super.initState();
    loadTagihanData();
  }

  Future<void> loadTagihanData() async {
    try {
      final String response = await rootBundle.loadString('../assets/data/tagihan.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        tagihanList = data.cast<Map<String, dynamic>>();
      });
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
      body: SingleChildScrollView(
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
              DataCell(Text(item['status_bayar'] == 'lunas' ? 'Lunas' : 'Belum Lunas')),
              DataCell(Text('Rp ${item['jumlah_bayar']}')),
              DataCell(Text(item['tanggal_bayar'])),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

