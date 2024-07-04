import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath; // Tambahkan variabel untuk menampung path gambar

  // Tambahkan constructor untuk menerima path gambar
  CustomImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          imagePath, // Menggunakan path gambar yang diterima dari constructor
          fit: BoxFit.cover, // Mengatur gambar agar ditampilkan sesuai ukuran CircleAvatar
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}