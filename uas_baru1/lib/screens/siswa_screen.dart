import 'package:flutter/material.dart';

class SiswaScreen extends StatefulWidget {
  @override
  _SiswaScreenState createState() => _SiswaScreenState();
}

class _SiswaScreenState extends State<SiswaScreen> {
  final List<Map<String, dynamic>> _siswaList = [];

  void _addSiswa(String nim, String nama, String alamat, String tgl_lahir, String jenis_kelamin, String agama, String nama_ortu, String no_tlp, String foto, String status) {
    setState(() {
      _siswaList.add({
        'nim': nim,
        'name': nama,
        'alamat': alamat,
        'tgl_lahir': tgl_lahir,
        'jenis_kelamin': jenis_kelamin,
        'agama': agama,
        'nama_ortu': nama_ortu,
        'no_tlp': no_tlp,
        'foto': foto,
        'status': status,
      });
    });
  }

  void _showAddSiswaModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16),
          child: SingleChildScrollView(
            child: AddSiswaForm(onAddSiswa: _addSiswa),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _siswaList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(_siswaList[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('NISN: ${_siswaList[index]['nim']}\nAlamat: ${_siswaList[index]['alamat']}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to details screen
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSiswaModal(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class AddSiswaForm extends StatefulWidget {
  final Function(String, String, String, String, String, String, String, String, String, String) onAddSiswa;

  AddSiswaForm({required this.onAddSiswa});

  @override
  _AddSiswaFormState createState() => _AddSiswaFormState();
}

class _AddSiswaFormState extends State<AddSiswaForm> {
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAddSiswa(
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
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              onPressed: _submitForm,
              child: Text('Tambah Siswa'),
            ),
          ],
        ),
      ),
    );
  }
}
