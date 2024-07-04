import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart'; // Import package printing
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'AppBuilder.dart';

class TransaksiPage extends StatefulWidget {
  final String nim; // Variabel nim untuk menyimpan NIM pengguna

  const TransaksiPage({Key? key, required this.nim}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String? selectedItem;
  List<String> items = [];
  Map<String, List<Map<String, dynamic>>> tagihanData = {};
  List<Map<String, dynamic>> tagihan = [];
  List<Map<String, dynamic>> transaksi = [];

  @override
  void initState() {
    super.initState();
    getTransaksi();
  }

  Future<void> getTransaksi() async {
    final jsonString =
    await rootBundle.loadString("data/tagihan.json");
    final data = json.decode(jsonString) as Map<String, dynamic>;
    setState(() {
      tagihanData = data.map((key, value) => MapEntry(
        key,
        (value as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
      ));
      items = tagihanData.keys.toList();
      selectedItem = items.first;
      tagihan = tagihanData[selectedItem!]!;
      transaksi = tagihan
          .where((item) => item["status"] == "Sudah Dibayar")
          .toList();
    });
  }

  void _printTransaksiReport() {
    List<List<dynamic>> data = [];

    data.add([
      'Bulan Tagihan',
      'Status Tagihan',
      'Jumlah Bayar',
      'Tanggal Bayar',
    ]);

    for (var item in transaksi) {
      data.add([
        item['bulan'],
        'Lunas', // Ubah status menjadi 'Lunas'
        item['jml_bayar'].toString(),
        item['tgl_bayar'],
      ]);
    }

    _printData(data);
  }

  void _printData(List<List<dynamic>> data) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      build: (context) => [
        pw.Table.fromTextArray(
          context: context,
          data: data,
        ),
      ],
    ));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Appbuilder(nim: widget.nim)),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedItem,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue;
                  transaksi = tagihanData[newValue!]!;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _printTransaksiReport();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Cetak'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Bulan Tagihan')),
                    DataColumn(label: Text('Status Tagihan')),
                    DataColumn(label: Text('Jumlah Bayar')),
                    DataColumn(label: Text('Tanggal Bayar')),
                  ],
                  rows: transaksi.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item['bulan'])),
                      DataCell(Text('Lunas')),
                      DataCell(Text(item['jml_bayar'].toString())),
                      DataCell(Text(item['tgl_bayar'])),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
