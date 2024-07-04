import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilSiswa extends StatefulWidget {
  @override
  _ProfilSiswaState createState() => _ProfilSiswaState();
}

class _ProfilSiswaState extends State<ProfilSiswa> {
  List<Map<String, dynamic>> studentList = [];
  Map<String, dynamic>? selectedStudent;
  List<String> studentNames = [];

  @override
  void initState() {
    super.initState();
    loadStudentData();
  }

  Future<void> loadStudentData() async {
    try {
      final String response = await rootBundle.loadString('../assets/data/profile.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        studentList = data.map((student) => Map<String, dynamic>.from(student)).toList();
        studentNames = studentList.map((student) => student['name'].toString()).toList();
        if (studentList.isNotEmpty) {
          selectedStudent = studentList[0];
        }
      });
    } catch (e) {
      print('Error loading student data: $e');
    }
  }

  void _addStudent(Map<String, dynamic> newStudent) {
    setState(() {
      studentList.add(newStudent);
      studentNames.add(newStudent['name']);
    });
  }

  void _showAddStudentDialog() {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _nimController = TextEditingController();
    final _dobController = TextEditingController();
    final _addressController = TextEditingController();
    final _parentsController = TextEditingController();
    final _statusController = TextEditingController();
    final _phoneController = TextEditingController();
    final _imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Siswa'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nama'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama siswa';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nimController,
                  decoration: InputDecoration(labelText: 'NIM'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan NIM';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan tanggal lahir';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Alamat'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan alamat';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _parentsController,
                  decoration: InputDecoration(labelText: 'Nama Orang Tua'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama orang tua';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan status';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'No. Telpon'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan no. telpon';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: 'URL Gambar'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan URL gambar';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _addStudent({
                  'name': _nameController.text,
                  'nim': _nimController.text,
                  'dob': _dobController.text,
                  'address': _addressController.text,
                  'parents': _parentsController.text,
                  'status': _statusController.text,
                  'phone': _phoneController.text,
                  'image_url': _imageUrlController.text,
                });
                Navigator.pop(context);
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Siswa'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddStudentDialog,
          ),
        ],
      ),
      body: studentList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: selectedStudent != null ? selectedStudent!['name'] : null,
                items: studentNames.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStudent = studentList.firstWhere((student) => student['name'] == newValue);
                  });
                },
              ),
              SizedBox(height: 20),
              if (selectedStudent != null) ...[
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      selectedStudent!['image_url'],
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  selectedStudent!['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'NIM: ${selectedStudent!['nim']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                buildInfoRow(Icons.cake, 'Tanggal Lahir: ${selectedStudent!['dob']}'),
                buildInfoRow(Icons.home, 'Alamat: ${selectedStudent!['address']}'),
                buildInfoRow(Icons.people, 'Nama Orang Tua: ${selectedStudent!['parents']}'),
                buildInfoRow(Icons.info, 'Status: ${selectedStudent!['status']}'),
                buildInfoRow(Icons.phone, 'No. Telpon: ${selectedStudent!['phone']}'),
                ElevatedButton(
                  onPressed: () {
                    print('Hello, world!');
                  },
                  child: Text('Tambah User'),
                ),
              ],
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
