import 'package:flutter/material.dart';

class ProfilSiswa extends StatefulWidget {
  @override
  _ProfilSiswaState createState() => _ProfilSiswaState();
}

class _ProfilSiswaState extends State<ProfilSiswa> {
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
    'kelas': '8',
    'nomor_absen': '1',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0066A2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Siswa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildInfoGrid(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: _editProfil,
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(siswaData['foto']),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    siswaData['nama'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kelas ${siswaData['kelas']} | Absen ${siswaData['nomor_absen']}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGrid() {
    List<MapEntry<String, String>> items = [
      MapEntry('NIS', siswaData['nis']),
      MapEntry('Alamat', siswaData['alamat']),
      MapEntry('Tanggal Lahir', siswaData['tanggal_lahir']),
      MapEntry('Jenis Kelamin', siswaData['jenis_kelamin']),
      MapEntry('Agama', siswaData['agama']),
      MapEntry('Nama Orang Tua', siswaData['nama_ortu']),
      MapEntry('Telepon', siswaData['telp']),
      MapEntry('Status', siswaData['status']),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildInfoItem(items[index].key, items[index].value);
      },
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _editProfil() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              children: siswaData.entries.map((entry) {
                return TextField(
                  decoration: InputDecoration(labelText: entry.key),
                  controller: TextEditingController(text: entry.value.toString()),
                  onChanged: (value) {
                    siswaData[entry.key] = value;
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                setState(() {
                  // Data sudah diperbarui di siswaData
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}