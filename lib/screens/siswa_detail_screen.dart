import 'package:flutter/material.dart';
import 'siswa_edit_screen.dart'; // Import SiswaEditScreen

class SiswaDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> siswa = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Siswa Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('NIM: ${siswa['nim']}'),
            Text('Nama: ${siswa['name']}'),
            Text('Alamat: ${siswa['alamat']}'),
            Text('Tanggal Lahir: ${siswa['tgl_lahir']}'),
            Text('Jenis Kelamin: ${siswa['jenis_kelamin']}'),
            Text('Nama Orang Tua: ${siswa['nama_ortu']}'),
            Text('No telepon: ${siswa['no_tlp']}'),
            Text('Foto: ${siswa['foto']}'),
            Text('Status: ${siswa['status']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/edit-siswa',
                  arguments: siswa,
                ).then((result) {
                  if (result != null) {
                    // Handle result if needed
                  }
                });
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
