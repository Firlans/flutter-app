import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SiswaAddScreen extends StatelessWidget {
  final Function(String, String, String, String, String, String, String, String, String, String) onAddSiswa;

  SiswaAddScreen({required this.onAddSiswa});

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'nim': '',
    'name': '',
    'alamat': '',
    'tgl_lahir': '',
    'jenis_kelamin': '',
    'agama': '',
    'nama_ortu': '',
    'no_tlp': '',
    'foto': '',
    'status': '',
  };

  Future<void> _saveFormDataToLocal() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/siswa_data.json');

    // Load existing data if any
    List<dynamic> siswaData = [];
    if (await file.exists()) {
      String fileContent = await file.readAsString();
      siswaData = json.decode(fileContent);
    }

    // Add new siswa data to list
    siswaData.add({
      'nim': _formData['nim'],
      'name': _formData['name'],
      'alamat': _formData['alamat'],
      'tgl_lahir': _formData['tgl_lahir'],
      'jenis_kelamin': _formData['jenis_kelamin'],
      'agama': _formData['agama'],
      'nama_ortu': _formData['nama_ortu'],
      'no_tlp': _formData['no_tlp'],
      'foto': _formData['foto'],
      'status': _formData['status'],
    });

    // Save updated data to file
    await file.writeAsString(json.encode(siswaData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Siswa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['nim'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['name'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['alamat'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['tgl_lahir'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis kelamin tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['jenis_kelamin'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Agama tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['agama'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Orang Tua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama orang tua tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['nama_ortu'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['no_tlp'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Foto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Foto tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['foto'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Status tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['status'] = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    onAddSiswa(
                      _formData['nim']!,
                      _formData['name']!,
                      _formData['alamat']!,
                      _formData['tgl_lahir']!,
                      _formData['jenis_kelamin']!,
                      _formData['agama']!,
                      _formData['nama_ortu']!,
                      _formData['no_tlp']!,
                      _formData['foto']!,
                      _formData['status']!,
                    );

                    _saveFormDataToLocal(); // Panggil fungsi untuk menyimpan ke JSON

                    Navigator.of(context).pop();
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
