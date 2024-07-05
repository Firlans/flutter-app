import 'package:flutter/material.dart';

class TagihanLain extends StatefulWidget {
  @override
  _TagihanLainState createState() => _TagihanLainState();
}

class _TagihanLainState extends State<TagihanLain> {
  // Data dummy untuk contoh
  List<Map<String, dynamic>> tagihanList = [
    {
      'id': 1,
      'nama': 'Uang Buku',
      'jumlah': 250000,
      'status': 'Belum Lunas',
      'tanggal_jatuh_tempo': '2024-08-15',
    },
    {
      'id': 2,
      'nama': 'Uang Kegiatan',
      'jumlah': 150000,
      'status': 'Lunas',
      'tanggal_jatuh_tempo': '2024-07-30',
    },
    {
      'id': 3,
      'nama': 'Uang Seragam',
      'jumlah': 300000,
      'status': 'Belum Lunas',
      'tanggal_jatuh_tempo': '2024-09-01',
    },
    // Tambahkan data tagihan lain sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan Lain'),
        centerTitle: true,
        backgroundColor: Color(0xFF0066A2),
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Light background color
        child: ListView.builder(
          itemCount: tagihanList.length,
          itemBuilder: (context, index) {
            final tagihan = tagihanList[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(tagihan['nama']),
                subtitle: Text('Rp ${tagihan['jumlah']}'),
                trailing: Chip(
                  label: Text(tagihan['status']),
                  backgroundColor: tagihan['status'] == 'Lunas' ? Colors.green : Colors.red,
                ),
                onTap: () => _showTagihanDetail(tagihan),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showTagihanDetail(Map<String, dynamic> tagihan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Tagihan'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama Tagihan: ${tagihan['nama']}'),
              Text('Jumlah: Rp ${tagihan['jumlah']}'),
              Text('Status: ${tagihan['status']}'),
              Text('Tanggal Jatuh Tempo: ${tagihan['tanggal_jatuh_tempo']}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            if (tagihan['status'] == 'Belum Lunas')
              ElevatedButton(
                child: Text('Bayar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showPaymentConfirmation(tagihan);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFFFFF), // Button color
                ),
              ),
          ],
        );
      },
    );
  }

  void _showPaymentConfirmation(Map<String, dynamic> tagihan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text('Apakah Anda yakin ingin membayar ${tagihan['nama']} sebesar Rp ${tagihan['jumlah']}?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Ya, Bayar'),
              onPressed: () {
                // TODO: Proses pembayaran
                Navigator.of(context).pop();
                setState(() {
                  tagihan['status'] = 'Lunas';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pembayaran berhasil!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}