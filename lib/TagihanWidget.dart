// import 'package:flutter/material.dart';

// class TagihanWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> tagihan;

//   TagihanWidget({required this.tagihan});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Tagihan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: tagihan.length,
//                 itemBuilder: (context, index) {
//                   final item = tagihan[index];
//                   return Card(
//                     elevation: 2,
//                     margin: EdgeInsets.only(bottom: 8),
//                     child: ListTile(
//                       title: Text(item['bulan'], style: TextStyle(fontWeight: FontWeight.bold)),
//                       subtitle: Text('Rp ${item['jml_bayar']}'),
//                       trailing: Chip(
//                         label: Text(
//                           item['status'] == 'Sudah Dibayar' ? 'Lunas' : 'Belum Lunas',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor: item['status'] == 'Sudah Dibayar' ? Colors.green : Colors.red,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TagihanWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tagihan;

  TagihanWidget({required this.tagihan});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          Axis.horizontal, // Memungkinkan scrolling horizontal jika overflow
      child: DataTable(
        columns: [
          DataColumn(label: Text('Bulan Tagihan')),
          DataColumn(label: Text('Status Tagihan')),
          DataColumn(label: Text('Jumlah Bayar')),
          DataColumn(label: Text('Tanggal Bayar')),
        ],
        rows: tagihan.map((item) {
          return DataRow(cells: [
            DataCell(Text(item['bulan'])),
            DataCell(Text(
                item['status'] == 'Sudah Dibayar' ? 'Lunas' : 'Belum Lunas')),
            DataCell(Text(item['jml_bayar'].toString())),
            DataCell(Text(item['tgl_bayar'])),
          ]);
        }).toList(),
      ),
    );
  }
}
