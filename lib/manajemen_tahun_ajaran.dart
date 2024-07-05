import 'package:flutter/material.dart';

class ManajemenTahunAjaran extends StatefulWidget {
  @override
  _ManajemenTahunAjaranState createState() => _ManajemenTahunAjaranState();
}

class _ManajemenTahunAjaranState extends State<ManajemenTahunAjaran> {
  List<Map<String, dynamic>> tahunAjaranList = [
    {'id': 1, 'tahun_ajaran': '2022/2023', 'is_active': false},
    {'id': 2, 'tahun_ajaran': '2023/2024', 'is_active': true},
    {'id': 3, 'tahun_ajaran': '2024/2025', 'is_active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Tahun Ajaran'),
      ),
      body: ListView.builder(
        itemCount: tahunAjaranList.length,
        itemBuilder: (context, index) {
          final tahunAjaran = tahunAjaranList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(tahunAjaran['tahun_ajaran']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: tahunAjaran['is_active'],
                    onChanged: (bool value) {
                      setState(() {
                        tahunAjaranList[index]['is_active'] = value;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTahunAjaran(tahunAjaran),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTahunAjaran(tahunAjaran['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTahunAjaran,
        child: Icon(Icons.add),
        tooltip: 'Tambah Tahun Ajaran',
      ),
    );
  }

  void _addTahunAjaran() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTahunAjaran = '';
        return AlertDialog(
          title: Text('Tambah Tahun Ajaran'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Contoh: 2025/2026"),
            onChanged: (value) {
              newTahunAjaran = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                if (newTahunAjaran.isNotEmpty) {
                  setState(() {
                    tahunAjaranList.add({
                      'id': tahunAjaranList.length + 1,
                      'tahun_ajaran': newTahunAjaran,
                      'is_active': false,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _editTahunAjaran(Map<String, dynamic> tahunAjaran) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedTahunAjaran = tahunAjaran['tahun_ajaran'];
        return AlertDialog(
          title: Text('Edit Tahun Ajaran'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Contoh: 2025/2026"),
            controller: TextEditingController(text: editedTahunAjaran),
            onChanged: (value) {
              editedTahunAjaran = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                if (editedTahunAjaran.isNotEmpty) {
                  setState(() {
                    tahunAjaran['tahun_ajaran'] = editedTahunAjaran;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTahunAjaran(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Tahun Ajaran'),
          content: Text('Apakah Anda yakin ingin menghapus tahun ajaran ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Hapus'),
              onPressed: () {
                setState(() {
                  tahunAjaranList.removeWhere((tahunAjaran) => tahunAjaran['id'] == id);
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