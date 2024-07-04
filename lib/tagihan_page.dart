import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart'; // Import package printing
import 'DropdownButton.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

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

  Future<String> getTahunAjaran() async{
    final jsonString = await rootBundle.loadString("data/profile.json");
    final data = json.decode(jsonString) as Map<String, dynamic>;
    return data['tahun ajaran'];
  }

  Future<void> getTransaksi() async {
    final jsonString =
    await rootBundle.loadString("data/data.json"); // Path sesuai dengan struktur proyek Anda
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final tahunAjaran = await getTahunAjaran();
    setState(() {
      tagihanData = data.map((key, value) => MapEntry(
        key,
        (value as List).map((e) => e as Map<String, dynamic>).toList(),
      ));
      items = tagihanData.keys.toList();
      selectedItem = items.first;
      tagihan = tagihanData[selectedItem!]!;
      transaksi = tagihan.where((item) => item["status"] == "Sudah Dibayar").toList();
    });
  }

  void _printTransaksiReport() {
    // Membuat list data untuk tabel
    List<List<dynamic>> data = [];

    // Menambahkan header kolom
    data.add([
      'Bulan Tagihan',
      'Status Tagihan',
      'Jumlah Bayar',
      'Tanggal Bayar',
    ]);

    // Menambahkan data dari transaksi ke dalam list data
    for (var item in transaksi) {
      data.add([
        item['bulan'],
        item['status'] = 'Lunas',
        item['jml_bayar'].toString(),
        item['tgl_bayar'],
      ]);
    }

    // Panggil fungsi untuk mencetak menggunakan platform printing
    _printData(data);
  }

  void _printData(List<List<dynamic>> data) async {
    // Buat dokumen PDF
    final pdf = pw.Document();

    // Tambahkan halaman PDF dengan tabel
    pdf.addPage(pw.MultiPage(
      build: (context) => [
        pw.Table.fromTextArray(
          context: context,
          data: data,
        ),
      ],
    ));

    // Cetak dokumen menggunakan printer
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropDownButtonWidget(
              selectedItem: selectedItem,
              items: items,
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue;
                  // Update tagihan yang ditampilkan sesuai tahun ajaran dipilih
                  transaksi = tagihanData[newValue!]!;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementasi fungsi cetak
                _printTransaksiReport();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Warna latar belakang
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Cetak'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Memungkinkan scroll secara horizontal
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
                      DataCell(Text(
                          item['status'] == 'Sudah Dibayar' ? 'Lunas' : 'Belum Lunas')),
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
