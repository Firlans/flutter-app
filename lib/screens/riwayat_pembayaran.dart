import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RiwayatPembayaran extends StatefulWidget {
  @override
  _RiwayatPembayaranState createState() => _RiwayatPembayaranState();
}

class _RiwayatPembayaranState extends State<RiwayatPembayaran> {
  List<Map<String, dynamic>> riwayatList = [];

  @override
  void initState() {
    super.initState();
    loadRiwayatData();
  }

  Future<void> loadRiwayatData() async {
    try {
      final String response = await rootBundle.loadString('../assets/data/riwayat_pembayaran.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        riwayatList = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading riwayat pembayaran data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Pembayaran')),
      body: riwayatList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: riwayatList.length,
        itemBuilder: (context, index) {
          final riwayat = riwayatList[index];
          return ListTile(
            title: Text('Pembayaran SPP Bulan ${riwayat['bulan']}'),
            subtitle: Text('Tanggal: ${riwayat['tgl_bayar']}'),
            trailing: Text('Rp ${riwayat['jml_bayar']}'),
          );
        },
      ),
    );
  }
}
