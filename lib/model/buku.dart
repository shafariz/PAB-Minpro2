class Buku {
  final int? id;
  final String judul;
  final String penulis;
  final int tahun;
  final int totalHalaman;
  final String? userId;

  Buku({
    this.id,
    required this.judul,
    required this.penulis,
    required this.tahun,
    required this.totalHalaman,
    this.userId,
  });

  factory Buku.fromMap(Map<String, dynamic> map) {
    return Buku(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      judul: map['judul']?.toString() ?? '',
      penulis: map['penulis']?.toString() ?? '',
      tahun: map['tahun'] is int
          ? map['tahun']
          : int.parse(map['tahun'].toString()),
      totalHalaman: map['total_halaman'] is int
          ? map['total_halaman']
          : int.parse(map['total_halaman'].toString()),
      userId: map['user_id']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'penulis': penulis,
      'tahun': tahun,
      'total_halaman': totalHalaman,
      'user_id': userId,
    };
  }
}
