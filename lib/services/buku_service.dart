import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/buku.dart';

class BukuService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Buku>> getBuku() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return [];
    }

    final data = await supabase
        .from('books')
        .select()
        .eq('user_id', user.id)
        .order('id', ascending: false);

    return (data as List).map((item) => Buku.fromMap(item)).toList();
  }

  Future<void> tambahBuku(Buku buku) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final dataBuku = Buku(
      judul: buku.judul,
      penulis: buku.penulis,
      tahun: buku.tahun,
      totalHalaman: buku.totalHalaman,
      userId: user.id,
    );

    await supabase.from('books').insert(dataBuku.toMap());
  }

  Future<void> updateBuku(Buku buku) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    await supabase
        .from('books')
        .update({
          'judul': buku.judul,
          'penulis': buku.penulis,
          'tahun': buku.tahun,
          'total_halaman': buku.totalHalaman,
        })
        .eq('id', buku.id!)
        .eq('user_id', user.id);
  }

  Future<void> hapusBuku(int id) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    await supabase.from('books').delete().eq('id', id).eq('user_id', user.id);
  }
}
