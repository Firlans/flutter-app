import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class SiswaAddScreen extends StatelessWidget {
  final Function(
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      ) onAddSiswa;

  SiswaAddScreen({super.key, required this.onAddSiswa});

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'nim': '',
    'name': '',
    'alamat': '',
    'tgl_lahir': '',
    'jenis_kelamin': '',
    'nama_ortu': '',
    'no_tlp': '',
    'foto': '',
    'status': '',
  };

  Future<void> _saveFormDataToLocal() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/assets/data/data_siswa.json');

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
        title: const Text('Tambah Siswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'NIM'),
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
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
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
                decoration: const InputDecoration(labelText: 'Alamat'),
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
                decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir tidak boleh kosong';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _formData['tgl_lahir'] = pickedDate.toString();
                  }
                },
              ),
              const SizedBox(height: 10),
              RadioGroupWidget(
                labelText: 'Jenis Kelamin',
                options: ['Laki-laki', 'Perempuan'],
                onSelected: (value) {
                  _formData['jenis_kelamin'] = value;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Orang Tua'),
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
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
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
                decoration: const InputDecoration(labelText: 'Foto'),
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
              RadioGroupWidget(
                labelText: 'Status',
                options: ['Aktif', 'Tidak Aktif'],
                onSelected: (value) {
                  _formData['status'] = value;
                },
              ),
              const SizedBox(height: 20),
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
                      _formData['nama_ortu']!,
                      _formData['no_tlp']!,
                      _formData['foto']!,
                      _formData['status']!,
                    );

                    _saveFormDataToLocal(); // Panggil fungsi untuk menyimpan ke JSON

                    Navigator.of(context).pop();
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

class RadioGroupWidget extends StatefulWidget {
  final String labelText;
  final List<String> options;
  final Function(String) onSelected;

  const RadioGroupWidget({
    required this.labelText,
    required this.options,
    required this.onSelected,
  });

  @override
  _RadioGroupWidgetState createState() => _RadioGroupWidgetState();
}

class _RadioGroupWidgetState extends State<RadioGroupWidget> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.labelText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: widget.options
              .map(
                (option) => RadioListTile(
              title: Text(option),
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value as String?;
                });
                widget.onSelected(value as String);
              },
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
