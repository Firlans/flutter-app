import 'package:flutter/material.dart';

class KomponenPembayaranPage extends StatefulWidget {
  @override
  _KomponenPembayaranPageState createState() => _KomponenPembayaranPageState();
}

class _KomponenPembayaranPageState extends State<KomponenPembayaranPage> {
  List<String> komponenPembayaran = ['SPP', 'Uang Gedung', 'Seragam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Komponen Pembayaran'),
      ),
      body: ListView.builder(
        itemCount: komponenPembayaran.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(komponenPembayaran[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editKomponen(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteKomponen(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _tambahKomponen,
      ),
    );
  }

  void _tambahKomponen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newKomponen = '';
        return AlertDialog(
          title: Text('Tambah Komponen Baru'),
          content: TextField(
            onChanged: (value) {
              newKomponen = value;
            },
            decoration: InputDecoration(hintText: "Nama Komponen"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Tambah'),
              onPressed: () {
                setState(() {
                  komponenPembayaran.add(newKomponen);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editKomponen(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedKomponen = komponenPembayaran[index];
        return AlertDialog(
          title: Text('Edit Komponen'),
          content: TextField(
            onChanged: (value) {
              editedKomponen = value;
            },
            decoration: InputDecoration(hintText: "Nama Komponen"),
            controller: TextEditingController(text: komponenPembayaran[index]),
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
                  komponenPembayaran[index] = editedKomponen;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteKomponen(int index) {
    setState(() {
      komponenPembayaran.removeAt(index);
    });
  }
}