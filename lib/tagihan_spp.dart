import 'package:flutter/material.dart';
import 'halaman_pembayaran.dart';

class TagihanSPP extends StatefulWidget {
  @override
  _TagihanSPPState createState() => _TagihanSPPState();
}

class _TagihanSPPState extends State<TagihanSPP> {
  String selectedTahunAjaran = '2023/2024';
  List<String> tahunAjaranList = ['2022/2023', '2023/2024', '2024/2025'];

  // Data dummy untuk contoh
  List<Map<String, dynamic>> tagihanList = [
    {'bulan': 'Juli', 'jumlah': 500000, 'status': 'Lunas', 'tanggal_bayar': '2023-07-05'},
    {'bulan': 'Agustus', 'jumlah': 500000, 'status': 'Lunas', 'tanggal_bayar': '2023-08-03'},
    {'bulan': 'September', 'jumlah': 500000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
    {'bulan': 'Oktober', 'jumlah': 500000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
    // Tambahkan data untuk bulan-bulan lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan SPP'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedTahunAjaran,
              isExpanded: true,
              items: tahunAjaranList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedTahunAjaran = newValue;
                    // TODO: Ambil data tagihan berdasarkan tahun ajaran yang dipilih
                  });
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tagihanList.length,
              itemBuilder: (context, index) {
                final tagihan = tagihanList[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text('SPP ${tagihan['bulan']}'),
                    subtitle: Text('Rp ${tagihan['jumlah']}'),
                    trailing: Chip(
                      label: Text(tagihan['status']),
                      backgroundColor: tagihan['status'] == 'Lunas' ? Colors.green : Colors.red,
                    ),
                    onTap: () {
                      _showTagihanDetail(tagihan);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTagihanDetail(Map<String, dynamic> tagihan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Tagihan SPP'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bulan: ${tagihan['bulan']}'),
              Text('Jumlah: Rp ${tagihan['jumlah']}'),
              Text('Status: ${tagihan['status']}'),
              Text('Tanggal Bayar: ${tagihan['tanggal_bayar']}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (tagihan['status'] == 'Belum Lunas')
              ElevatedButton(
                child: Text('Bayar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  _navigateToHalamanPembayaran(tagihan);
                },
              ),
          ],
        );
      },
    );
  }

  void _navigateToHalamanPembayaran(Map<String, dynamic> tagihan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanPembayaran(
          tagihan: {
            'jenis': 'SPP',
            'bulan': tagihan['bulan'],
            'jumlah': tagihan['jumlah'],
          },
        ),
      ),
    );
  }
}