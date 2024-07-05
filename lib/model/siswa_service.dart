// siswa_service.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uas_baru1/model//siswa_model.dart'; // Sesuaikan dengan path model siswa

Future<Siswa> loadSiswaDetail() async {
  final jsonString = await rootBundle.loadString('assets/siswa_detail.json');
  final jsonData = json.decode(jsonString) as Map<String, dynamic>;

  return Siswa.fromJson(jsonData);
}
