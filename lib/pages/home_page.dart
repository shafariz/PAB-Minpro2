import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/theme_controller.dart';
import '../model/buku.dart';
import '../services/buku_service.dart';
import 'form_buku_page.dart';
import 'welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BukuService bukuService = BukuService();
  final ThemeController themeController = Get.find<ThemeController>();

  List<Buku> daftarBuku = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ambilDataBuku();
  }

  Future<void> ambilDataBuku() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await bukuService.getBuku();

      if (!mounted) return;
      setState(() {
        daftarBuku = data;
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data buku',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> bukaForm({Buku? buku}) async {
    final hasil = await Get.to(() => FormBukuPage(buku: buku));

    if (hasil == 'tambah') {
      await ambilDataBuku();
      Get.snackbar(
        'Berhasil',
        'Buku berhasil ditambahkan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (hasil == 'edit') {
      await ambilDataBuku();
      Get.snackbar(
        'Berhasil',
        'Data buku berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> hapusData(Buku buku) async {
    final konfirmasi = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus Buku'),
        content: Text('Yakin ingin menghapus "${buku.judul}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      try {
        await bukuService.hapusBuku(buku.id!);
        await ambilDataBuku();
        Get.snackbar(
          'Berhasil',
          'Buku berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Gagal menghapus buku',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> logout() async {
    final konfirmasi = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah anda ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Tidak"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Ya"),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      await Supabase.instance.client.auth.signOut();
      Get.offAll(() => const WelcomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgCard = isDark ? const Color(0xFF2B2530) : const Color(0xFFF5F1F7);

    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              width: double.infinity,
              height: 240,
              color: const Color(0xFF8F8395),
              child: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      right: 10,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              themeController.toggleTheme();
                            },
                            icon: Icon(
                              isDark ? Icons.light_mode : Icons.dark_mode,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: logout,
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "My Favorite Books",
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Keep your best reads in one place ⸜(｡˃ ᵕ ˂ )⸝♡",
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : daftarBuku.isEmpty
                    ? const Center(
                        child: Text(
                          "No favorite books yet.\nTap + to add.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: daftarBuku.length,
                        itemBuilder: (context, index) {
                          final buku = daftarBuku[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Card(
                              color: bgCard,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                title: Text(
                                  buku.judul,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${buku.penulis}\n"
                                  "Year: ${buku.tahun} | "
                                  "Pages: ${buku.totalHalaman}",
                                ),
                                isThreeLine: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => bukaForm(buku: buku),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => hapusData(buku),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF8F8395),
        foregroundColor: Colors.white,
        onPressed: () => bukaForm(),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height + 20,
      size.width * 0.5,
      size.height - 10,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 40,
      size.width,
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
