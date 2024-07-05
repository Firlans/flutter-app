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
  Map<String, List<Map<String, dynamic>>> tagihanPerTahun = {
    '2022/2023': [
      {'bulan': 'Juli', 'jumlah': 450000, 'status': 'Lunas', 'tanggal_bayar': '2022-07-05'},
      {'bulan': 'Agustus', 'jumlah': 450000, 'status': 'Lunas', 'tanggal_bayar': '2022-08-03'},
      {'bulan': 'September', 'jumlah': 450000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
      // Tambahkan data untuk bulan-bulan lainnya
    ],
    '2023/2024': [
      {'bulan': 'Juli', 'jumlah': 500000, 'status': 'Lunas', 'tanggal_bayar': '2023-07-05'},
      {'bulan': 'Agustus', 'jumlah': 500000, 'status': 'Lunas', 'tanggal_bayar': '2023-08-03'},
      {'bulan': 'September', 'jumlah': 500000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
      // Tambahkan data untuk bulan-bulan lainnya
    ],
    '2024/2025': [
      {'bulan': 'Juli', 'jumlah': 550000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
      {'bulan': 'Agustus', 'jumlah': 550000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
      {'bulan': 'September', 'jumlah': 550000, 'status': 'Belum Lunas', 'tanggal_bayar': '-'},
      // Tambahkan data untuk bulan-bulan lainnya
    ],
  };

  List<Map<String, dynamic>> get tagihanList => tagihanPerTahun[selectedTahunAjaran]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan SPP'),
        centerTitle: true,
        backgroundColor: Color(0xFF0066A2),
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Light background color
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                value: selectedTahunAjaran,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFFFFF), // Button color
                ),
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