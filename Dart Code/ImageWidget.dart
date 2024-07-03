// import 'package:flutter/material.dart';

// class CustomImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 75,
//       backgroundImage: NetworkImage(
//           '../assets/images/dd705e9b7148a56a8c24c9ce13525a89.webp'),
//     );

//     // return CircleAvatar(
//   }
// }

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          '../assets/images/dd705e9b7148a56a8c24c9ce13525a89.webp', // Ganti dengan URL gambar Anda
          fit: BoxFit
              .cover, // Mengatur gambar agar ditampilkan sesuai ukuran CircleAvatar
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
