import 'package:flutter/material.dart';
import 'ButtonCetak.dart';
import 'DropDownButton.dart';
import 'ImageWidget.dart';
import 'TagihanWidget.dart';

class Appbuilder extends StatefulWidget {
  @override
  _DropdownScreenState createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<Appbuilder> {
  String? selectedItem;
  final List<String> items = [
    '2023/2024',
    '2022/2023'
  ]; // Tahun ajaran saat ini dan sebelumnya

  // Contoh data tagihan untuk setiap tahun ajaran
  final Map<String, List<Map<String, dynamic>>> tagihanData = {
    '2023/2024': [
      {
        'bulan': 'Januari',
        'jml_bayar': 100000,
        'tgl_bayar': '2024-01-15',
        'status': 'Belum Dibayar'
      },
      {
        'bulan': 'Februari',
        'jml_bayar': 100000,
        'tgl_bayar': '2024-02-15',
        'status': 'Sudah Dibayar'
      },
      // Tambahkan data tagihan lainnya untuk tahun ajaran 2023/2024 di sini
    ],
    '2022/2023': [
      {
        'bulan': 'September',
        'jml_bayar': 100000,
        'tgl_bayar': '2023-09-15',
        'status': 'Sudah Dibayar'
      },
      {
        'bulan': 'Oktober',
        'jml_bayar': 100000,
        'tgl_bayar': '2023-10-15',
        'status': 'Sudah Dibayar'
      },
      // Tambahkan data tagihan lainnya untuk tahun ajaran 2022/2023 di sini
    ],
  };

  List<Map<String, dynamic>> tagihan =
      []; // Tagihan yang ditampilkan sesuai tahun ajaran dipilih

  @override
  void initState() {
    super.initState();
    // Set tagihan awal saat pertama kali aplikasi dimuat
    tagihan = tagihanData[items.first]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UAS - DAFA JULIANTO ABDILLAH')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomImage(), // menampilkan gambar
            SizedBox(height: 20), // Spacer antara tombol dan dropdown
            Center(
              child: Text('Dafa Julianto Abdillah',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ), // Nama pengguna di tengah
            Center(
              child: Text('NIM: 12345678', style: TextStyle(fontSize: 16)),
            ), // NIM di tengah
            SizedBox(height: 20), // Spacer antara tombol dan dropdown
            ButtonCetak(), // Tambahkan tombol "Cetak" di sini
            SizedBox(height: 20), // Spacer antara tombol dan dropdown
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
            SizedBox(height: 20), // Spacer antara tombol dan dropdown
            Expanded(
              child: TagihanWidget(
                  tagihan: tagihan), // Menampilkan informasi tagihan
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Appbuilder()));
