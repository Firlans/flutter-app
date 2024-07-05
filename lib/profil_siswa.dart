import 'package:flutter/material.dart';

class ProfilSiswa extends StatefulWidget {
  @override
  _ProfilSiswaState createState() => _ProfilSiswaState();
}

class _ProfilSiswaState extends State<ProfilSiswa> {
  // Data dummy untuk contoh
  Map<String, dynamic> siswaData = {
    'nis': '1234567890',
    'nama': 'John Doe',
    'alamat': 'Jl. Contoh No. 123',
    'tanggal_lahir': '2000-01-01',
    'jenis_kelamin': 'Laki-laki',
    'agama': 'Islam',
    'nama_ortu': 'Jane Doe',
    'telp': '08123456789',
    'foto': 'https://example.com/photo.jpg',
    'status': 'Aktif',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Siswa'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Implementasi fungsi edit profil
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(siswaData['foto']),
              ),
            ),
            SizedBox(height: 20),
            _buildInfoItem('NIS', siswaData['nis']),
            _buildInfoItem('Nama', siswaData['nama']),
            _buildInfoItem('Alamat', siswaData['alamat']),
            _buildInfoItem('Tanggal Lahir', siswaData['tanggal_lahir']),
            _buildInfoItem('Jenis Kelamin', siswaData['jenis_kelamin']),
            _buildInfoItem('Agama', siswaData['agama']),
            _buildInfoItem('Nama Orang Tua', siswaData['nama_ortu']),
            _buildInfoItem('Telepon', siswaData['telp']),
            _buildInfoItem('Status', siswaData['status']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}