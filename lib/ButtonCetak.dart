import 'package:flutter/material.dart';

class ButtonCetak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        print('Tombol Cetak Ditekan!');
      },
      icon: Icon(Icons.print, size: 24),
      label: Text(
        'Cetak',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Ganti primary menjadi backgroundColor
        foregroundColor: Colors.white, // Ganti onPrimary menjadi foregroundColor
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}