import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilSiswa extends StatefulWidget {
  @override
  _ProfilSiswaState createState() => _ProfilSiswaState();
}

class _ProfilSiswaState extends State<ProfilSiswa> {
  List<Map<String, dynamic>> siswaList = [];
  Map<String, dynamic> siswaData = {};

  String selectedNIS = '';

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function to fetch data when the widget initializes
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://localhost:1233/mahasiswa');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          siswaList = responseData.map((data) => Map<String, dynamic>.from(data)).toList();
          if (siswaList.isNotEmpty) {
            selectedNIS = siswaList[0]['Nim']; // Select the first NIS by default
            siswaData = siswaList[0];
          }
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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
                      _buildDropdown(),
                      SizedBox(height: 20),
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
                backgroundImage: NetworkImage(siswaData['Foto'] ?? ''),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    siswaData['NamaLengkap'] ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kelas ${siswaData['Kelas'] ?? ''} | Absen ${siswaData['nomor_absen'] ?? ''}',
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

  Widget _buildDropdown() {
    return DropdownButton<String>(
      value: selectedNIS,
      onChanged: (String? newValue) {
        setState(() {
          selectedNIS = newValue!;
          siswaData = siswaList.firstWhere((siswa) => siswa['Nim'] == selectedNIS);
        });
      },
      items: siswaList.map<DropdownMenuItem<String>>((Map<String, dynamic> siswa) {
        return DropdownMenuItem<String>(
          value: siswa['Nim'],
          child: Text(siswa['Nim']),
        );
      }).toList(),
    );
  }

  Widget _buildInfoGrid() {
    List<MapEntry<String, String>> items = [
      MapEntry('NIS', siswaData['Nim'] ?? ''),
      MapEntry('Alamat', siswaData['Alamat'] ?? ''),
      MapEntry('Tanggal Lahir', siswaData['tanggal_lahir'] ?? ''),
      MapEntry('Jenis Kelamin', siswaData['jenis_kelamin'] ?? ''),
      MapEntry('Agama', siswaData['agama'] ?? ''),
      MapEntry('Nama Orang Tua', siswaData['NamaOrtu'] ?? ''),
      MapEntry('Telepon', siswaData['Telp'] ?? ''),
      MapEntry('Status', siswaData['Status'] ?? ''),
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
