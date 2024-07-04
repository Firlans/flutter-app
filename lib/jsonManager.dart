import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class JsonManager {
  final String filePath;

  JsonManager(this.filePath);

  // Function untuk mengambil data dari file JSON
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        print('File not found: $filePath');
        return {}; // Mengembalikan map kosong jika file tidak ditemukan
      }
      final contents = await file.readAsString();
      final Map<String, dynamic> jsonData = jsonDecode(contents);
      return jsonData;
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

  // Function untuk update data ke file JSON
  Future<void> updateData(Map<String, dynamic> newData) async {
    try {
      final file = File(filePath);
      final jsonString = jsonEncode(newData);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  // Function untuk delete data (menghapus kunci tertentu dari file JSON)
  Future<void> deleteData(String key) async {
    try {
      final data = await fetchData();
      if (data.containsKey(key)) {
        data.remove(key);
        await updateData(data);
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDataByNIM(String nim) async {
    try {
      final contents = await rootBundle.loadString(filePath);
      final List<dynamic> jsonData = jsonDecode(contents);

      // Mencari objek dengan NIM yang cocok
      Map<String, dynamic>? user = jsonData.firstWhere(
            (item) => item['nim'] == nim,
        orElse: () => null,
      );

      if (user != null) {
        return user;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }
}

void main() async {
  final jsonManager = JsonManager('assets/data/profile.json');
  // Contoh pengambilan data berdasarkan nama
  final name = "12345678"; // Nama kunci yang ingin diambil dari JSON
  final data = await jsonManager.fetchDataByNIM(name);
  print('Data fetched by $name: $data');
}
