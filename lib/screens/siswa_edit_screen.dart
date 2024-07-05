import 'package:flutter/material.dart';

class SiswaEditScreen extends StatefulWidget {
  @override
  _SiswaEditScreenState createState() => _SiswaEditScreenState();
}

class _SiswaEditScreenState extends State<SiswaEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _siswa;

  @override
  Widget build(BuildContext context) {
    _siswa = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Siswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _siswa['nim'],
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['nim'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['name'],
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['name'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['alamat'],
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['alamat'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['tgl_lahir'],
                decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['tgl_lahir'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['jenis_kelamin'],
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis kelamin tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['jenis_kelamin'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['nama_ortu'],
                decoration: const InputDecoration(labelText: 'Nama Orang Tua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama orang tua tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['nama_ortu'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['no_tlp'],
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['no_tlp'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['foto'],
                decoration: const InputDecoration(labelText: 'Foto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Foto tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['foto'] = value!;
                },
              ),
              TextFormField(
                initialValue: _siswa['status'],
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Status tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _siswa['status'] = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop(_siswa);
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
