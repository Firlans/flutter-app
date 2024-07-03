import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AbsenTableScreen(),
    );
  }
}

class AbsenData {
  final String uuidCard;
  final String namaMhs;
  final DateTime createAt;

  AbsenData(
      {required this.uuidCard, required this.namaMhs, required this.createAt});

  factory AbsenData.fromJson(Map<String, dynamic> json) {
    return AbsenData(
      uuidCard: json['uuid_card'],
      namaMhs: json['nama_mhs'],
      createAt: DateTime.parse(json['CreateAt']),
    );
  }
}

Future<List<AbsenData>> fetchAbsenData() async {
  final response =
      await http.get(Uri.parse('http://localhost:1211/api/ListAbsen/GetData'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['Data'];
    return data.map((json) => AbsenData.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class AbsenTableScreen extends StatefulWidget {
  @override
  _AbsenTableScreenState createState() => _AbsenTableScreenState();
}

class _AbsenTableScreenState extends State<AbsenTableScreen> {
  late Future<List<AbsenData>> futureAbsenData;

  @override
  void initState() {
    super.initState();
    futureAbsenData = fetchAbsenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absen Data Table'),
      ),
      body: FutureBuilder<List<AbsenData>>(
        future: futureAbsenData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return DataTable(
              columns: [
                DataColumn(label: Text('UUID Card')),
                DataColumn(label: Text('Nama MHS')),
                DataColumn(label: Text('Created At')),
              ],
              rows: snapshot.data!.map((data) {
                return DataRow(cells: [
                  DataCell(Text(data.uuidCard)),
                  DataCell(Text(data.namaMhs)),
                  DataCell(Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(data.createAt))),
                ]);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
