import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ButtonCetak.dart';
import 'DropdownButton.dart';
import 'ImageWidget.dart';
import 'TagihanWidget.dart';

class AppBuilder extends StatefulWidget {
  @override
  _DropdownScreenState createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<AppBuilder> {
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
    final jsonString = await rootBundle.loadString('../assets/data/data.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;

    setState(() {
      tagihanData = data.map((key, value) => MapEntry(
        key,
        (value as List).map((e) => e as Map<String, dynamic>).toList(),
      ));
      items = tagihanData.keys.toList();
      tagihan = tagihanData[items.first]!;
    });
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
