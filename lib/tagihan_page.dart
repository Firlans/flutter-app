import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AppBuilder.dart';
import 'package:printing/printing.dart'; // Import package printing
import 'DropdownButton.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  String? selectedItem;
  List<String> items = [];
  Map<String, List<Map<String, dynamic>>> tagihanData = {};
  List<Map<String, dynamic>> tagihan = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final jsonString =
    await rootBundle.loadString("../assets/data/data.json"); // Path sesuai dengan struktur proyek Anda
    final data = json.decode(jsonString) as Map<String, dynamic>;

    setState(() {
      tagihanData = data.map((key, value) => MapEntry(
        key,
        (value as List).map((e) => e as Map<String, dynamic>).toList(),
      ));
      items = tagihanData.keys.toList();
      selectedItem = items.first;
      tagihan = tagihanData[selectedItem!]!;
    });
  }

  void _printTagihanReport() {
    // Membuat list data untuk tabel
    List<List<dynamic>> data = [];

    // Menambahkan header kolom
    data.add([
      'Bulan Tagihan',
      'Status Tagihan',
      'Jumlah Bayar',
      'Tanggal Bayar',
    ]);

    // Menambahkan data dari tagihan ke dalam list data
    for (var item in tagihan) {
      data.add([
        item['bulan'],
        item['status'] == 'Sudah Dibayar' ? 'Lunas' : 'Belum Lunas',
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
        title: const Text('Tagihan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Appbuilder()),
            ); // Navigate back to the previous screen
          },
        ),
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
                  tagihan = tagihanData[newValue!]!;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementasi fungsi cetak
                _printTagihanReport();
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
                  rows: tagihan.map((item) {
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
