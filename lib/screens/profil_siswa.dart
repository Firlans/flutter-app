import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilSiswa extends StatefulWidget {
  @override
  _ProfilSiswaState createState() => _ProfilSiswaState();
}

class _ProfilSiswaState extends State<ProfilSiswa> {
  Map<String, dynamic> studentData = {};

  @override
  void initState() {
    super.initState();
    loadStudentData();
  }

  Future<void> loadStudentData() async {
    final String response = await rootBundle.loadString('../assets/data/profile.json');
    final data = await json.decode(response);
    setState(() {
      studentData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (studentData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profil Siswa'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Siswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(
                    studentData['image_url'],
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                studentData['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'NIM: ${studentData['nim']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              buildInfoRow(Icons.cake, 'Tanggal Lahir: ${studentData['dob']}'),
              buildInfoRow(Icons.home, 'Alamat: ${studentData['address']}'),
              buildInfoRow(Icons.people, 'Nama Orang Tua: ${studentData['parents']}'),
              buildInfoRow(Icons.info, 'Status: ${studentData['status']}'),
              buildInfoRow(Icons.phone, 'No. Telpon: ${studentData['phone']}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 24, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            info,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
