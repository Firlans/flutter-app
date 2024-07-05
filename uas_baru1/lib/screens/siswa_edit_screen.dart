import 'package:flutter/material.dart';

class SiswaEditScreen extends StatefulWidget {
  final int siswaId;
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onUpdateSiswa;

  SiswaEditScreen({
    required this.siswaId,
    required this.initialData,
    required this.onUpdateSiswa,
  });

  @override
  _SiswaEditScreenState createState() => _SiswaEditScreenState();
}

class _SiswaEditScreenState extends State<SiswaEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  void initState() {
    super.initState();
    _formData['nim'] = widget.initialData['nim'];
    _formData['name'] = widget.initialData['name'];
    _formData['alamat'] = widget.initialData['alamat'];
    _formData['tgl_lahir'] = widget.initialData['tgl_lahir'];
    _formData['jenis_kelamin'] = widget.initialData['jenis_kelamin'];
    _formData['agama'] = widget.initialData['agama'];
    _formData['nama_ortu'] = widget.initialData['nama_ortu'];
    _formData['no_tlp'] = widget.initialData['no_tlp'];
    _formData['foto'] = widget.initialData['foto'];
    _formData['status'] = widget.initialData['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Siswa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _formData['nim'],
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
                initialValue: _formData['name'],
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
                initialValue: _formData['alamat'],
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
                initialValue: _formData['tgl_lahir'],
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
                initialValue: _formData['jenis_kelamin'],
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
                initialValue: _formData['agama'],
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
                initialValue: _formData['nama_ortu'],
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
                initialValue: _formData['no_tlp'],
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
                initialValue: _formData['foto'],
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
                initialValue: _formData['status'],
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
                    widget.onUpdateSiswa(_formData);
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
