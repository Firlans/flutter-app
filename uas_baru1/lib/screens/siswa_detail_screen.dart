import 'package:flutter/material.dart';

class SiswaDetailScreen extends StatelessWidget {
  final Map<String, dynamic> siswa;

  SiswaDetailScreen({required this.siswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Siswa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nama: ${siswa['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('NIM: ${siswa['nim']}'),
            Text('Alamat: ${siswa['alamat']}'),
            Text('Tanggal Lahir: ${siswa['tgl_lahir']}'),
            Text('Jenis Kelamin: ${siswa['jenis_kelamin']}'),
            Text('Agama: ${siswa['agama']}'),
            Text('Nama Orang Tua: ${siswa['nama_ortu']}'),
            Text('Nomor Telepon: ${siswa['no_tlp']}'),
            Text('Status: ${siswa['status']}'),
            // Tambahkan field lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
