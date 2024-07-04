import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ButtonCetak.dart';
import 'DropdownButton.dart';
import 'ImageWidget.dart';
import 'TagihanWidget.dart';
import 'jsonManager.dart';

class Appbuilder extends StatefulWidget {
  final String nim; // Tambahkan variabel nim

  Appbuilder({required this.nim}); // Update konstruktor

  @override
  _AppbuilderState createState() => _AppbuilderState();
}

class _AppbuilderState extends State<Appbuilder> {
  String? selectedItem;
  String? userName;
  String? imagePath;
  List<String> items = [];
  Map<String, List<Map<String, dynamic>>> tagihanData = {};
  List<Map<String, dynamic>> tagihan = []; // Tagihan yang ditampilkan sesuai tahun ajaran dipilih

  @override
  void initState() {
    super.initState();
    fetchData(); // Panggil fetchData saat initState
    loadUserData(); // Memuat data pengguna dari JSON
  }

  // Method untuk memuat data dari file JSON
  Future<void> fetchData() async {
    try {
      final jsonString = await rootBundle.loadString('data/tagihan.json');
      final data = json.decode(jsonString) as Map<String, dynamic>;

      setState(() {
        tagihanData = data.map((key, value) => MapEntry(
          key,
          (value as List).map((e) => e as Map<String, dynamic>).toList(),
        ));
        items = tagihanData.keys.toList();
        selectedItem = items.first; // Pilih item pertama sebagai nilai default
        tagihan = tagihanData[selectedItem!]!;
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error accordingly
    }
  }

  // Method untuk memuat data pengguna
  Future<void> loadUserData() async {
    final jsonManager = JsonManager("data/profile.json");
    final userData = await jsonManager.fetchDataByNIM(widget.nim);
    setState(() {
      userName = userData['name'];
      imagePath = 'assets/images/${userData['image_url']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UAS - ${userName ?? 'Loading...'}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomImage(imagePath: imagePath!), // menampilkan gambar
            SizedBox(height: 20), // Spacer antara tombol dan dropdown
            Center(
              child: Text(userName ?? 'Loading...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ), // Nama pengguna di tengah
            Center(
              child: Text('NIM: ${widget.nim}', style: TextStyle(fontSize: 16)),
            ), // NIM di tengah
            SizedBox(height: 20), // Spacer antara tombol dan dropdown
            ButtonCetak(widget.nim), // Tambahkan tombol "Cetak" di sini dengan nilai nim
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
                tagihan: tagihan,
              ), // Menampilkan informasi tagihan
            ),
          ],
        ),
      ),
    );
  }
}
