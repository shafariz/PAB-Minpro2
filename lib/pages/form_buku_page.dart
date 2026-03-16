import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/buku.dart';
import '../services/buku_service.dart';

class FormBukuPage extends StatefulWidget {
  final Buku? buku;

  const FormBukuPage({super.key, this.buku});

  @override
  State<FormBukuPage> createState() => _FormBukuPageState();
}

class _FormBukuPageState extends State<FormBukuPage> {
  final _formKey = GlobalKey<FormState>();
  final BukuService bukuService = BukuService();

  late TextEditingController judulController;
  late TextEditingController penulisController;
  late TextEditingController tahunController;
  late TextEditingController halamanController;

  bool isSaving = false;

  bool get isEdit => widget.buku != null;

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.buku?.judul ?? '');
    penulisController = TextEditingController(text: widget.buku?.penulis ?? '');
    tahunController = TextEditingController(
      text: widget.buku != null ? widget.buku!.tahun.toString() : '',
    );
    halamanController = TextEditingController(
      text: widget.buku != null ? widget.buku!.totalHalaman.toString() : '',
    );
  }

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    final buku = Buku(
      id: widget.buku?.id,
      judul: judulController.text.trim(),
      penulis: penulisController.text.trim(),
      tahun: int.parse(tahunController.text.trim()),
      totalHalaman: int.parse(halamanController.text.trim()),
    );

    try {
      if (isEdit) {
        await bukuService.updateBuku(buku);
        Get.back(result: 'edit');
      } else {
        await bukuService.tambahBuku(buku);
        Get.back(result: 'tambah');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    judulController.dispose();
    penulisController.dispose();
    tahunController.dispose();
    halamanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8F8395),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(isEdit ? 'Edit Book' : 'Add Book'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: judulController,
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Book title tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: penulisController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Author tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tahunController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Year tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Year harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: halamanController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Pages',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Total Pages tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Total Pages harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSaving ? null : simpanData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F8395),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(isEdit ? 'Update' : 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
