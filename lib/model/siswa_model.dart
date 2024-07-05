// siswa_model.dart

class Siswa {
  final String nim;
  final String name;
  final String alamat;
  final String tgl_lahir;
  final String jenis_kelamin;
  final String agama;
  final String nama_ortu;
  final String no_tlp;
  final String foto;
  final String status;

  Siswa({
    required this.nim,
    required this.name,
    required this.alamat,
    required this.tgl_lahir,
    required this.jenis_kelamin,
    required this.agama,
    required this.nama_ortu,
    required this.no_tlp,
    required this.foto,
    required this.status,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      nim: json['nim'],
      name: json['name'],
      alamat: json['alamat'],
      tgl_lahir: json['tgl_lahir'],
      jenis_kelamin: json['jenis_kelamin'],
      agama: json['agama'],
      nama_ortu: json['nama_ortu'],
      no_tlp: json['no_tlp'],
      foto: json['foto'],
      status: json['status'],
    );
  }
}
