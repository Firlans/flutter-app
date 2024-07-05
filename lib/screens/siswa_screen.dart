import 'package:flutter/material.dart';
import 'siswa_detail_screen.dart'; // Import SiswaDetailScreen

class SiswaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: 10, // Replace with actual data count
        itemBuilder: (context, index) {
          // Replace with actual data fetching logic
          Map<String, dynamic> siswa = {
            'nim': '123456',
            'name': 'Siswa $index',
            'alamat': 'Address',
            'tgl_lahir': '2000-01-01',
            'jenis_kelamin': 'Laki-laki',
            'nama_ortu': 'Ortu Name',
            'no_tlp': '08123456789',
            'foto': 'foto_url',
            'status': 'Aktif',
          };

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(siswa['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Details about ${siswa['name']}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/siswa-detail',
                  arguments: siswa,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-siswa').then((_) {
            // Handle callback if needed
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
