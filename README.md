# Favobooks

Shafa Rizqi Nur Wahidah (2409116041)
Sistem Informasi B 2024

## Deskripsi Aplikasi

**Favobooks** adalah aplikasi mobile berbasis Flutter yang digunakan untuk menyimpan dan mengelola daftar buku favorit pengguna. Aplikasi ini dikembangkan dari Mini Project 1 dan dilanjutkan pada Mini Project 2 dengan menambahkan integrasi database menggunakan **Supabase** serta fitur autentikasi pengguna.

Melalui aplikasi ini, setiap pengguna dapat membuat akun, login, lalu mengelola data buku favoritnya sendiri. Data buku yang ditambahkan oleh satu akun tidak akan tercampur dengan akun lain karena setiap data terhubung dengan **user_id** dari Supabase Auth.

Aplikasi ini juga memiliki tampilan antarmuka yang lebih menarik dengan perpaduan warna **Purple Ash (#8F8395)** dan **Vanilla (#F3E5AB)**, serta mendukung **Light Mode** dan **Dark Mode** untuk meningkatkan kenyamanan pengguna saat menggunakan aplikasi.

---

## Fitur Aplikasi

Aplikasi ini memiliki fitur **register** dan **login** menggunakan **Supabase Auth**, sehingga setiap pengguna harus masuk ke dalam akun masing-masing sebelum mengakses data buku. Setelah berhasil login, pengguna akan masuk ke halaman utama aplikasi.

Pada halaman utama, aplikasi menampilkan daftar buku favorit milik pengguna yang sedang login. Jika belum ada data buku, maka aplikasi akan menampilkan pesan bahwa belum ada buku favorit yang tersimpan.

Pengguna dapat menambahkan data buku baru melalui halaman form. Data yang diinput meliputi **judul buku**, **penulis**, **tahun terbit**, dan **total halaman**. Data tersebut kemudian disimpan ke database Supabase.

Selain menambahkan data, pengguna juga dapat **mengedit** data buku yang sudah tersimpan dan **menghapus** data buku dari daftar favorit. Setiap perubahan data akan langsung diperbarui dari database Supabase.

Aplikasi ini juga menyediakan **logout** dengan dialog konfirmasi, sehingga pengguna dapat keluar dari akun dengan aman. Selain itu, tersedia fitur **dark mode** yang dapat diaktifkan dari halaman utama aplikasi.

---

## Widget yang Digunakan

### 1. Struktural & Layout

| Widget | Fungsi |
|--------|--------|
| `GetMaterialApp` | Digunakan sebagai root aplikasi dan mendukung navigasi serta state management menggunakan GetX. |
| `Scaffold` | Menjadi struktur dasar setiap halaman aplikasi. |
| `SafeArea` | Menjaga tampilan agar tidak bertabrakan dengan status bar atau area layar perangkat. |
| `Column` | Menyusun widget secara vertikal dari atas ke bawah. |
| `Row` | Menyusun widget secara horizontal, misalnya pada ikon di header. |
| `Expanded` | Membuat widget mengisi sisa ruang yang tersedia. |
| `Center` | Menempatkan widget tepat di tengah area yang tersedia. |
| `Padding` | Memberi jarak pada isi widget agar tampilan lebih rapi. |
| `SizedBox` | Memberikan jarak antar widget. |
| `Container` | Digunakan untuk membentuk area tertentu seperti header, card, dan elemen dekoratif lainnya. |
| `Stack` | Menumpuk widget di atas widget lain, misalnya pada bagian header. |
| `Positioned` | Mengatur posisi widget tertentu di dalam `Stack`. |
| `SingleChildScrollView` | Membuat konten dapat di-scroll jika melebihi ukuran layar. |
| `ClipPath` | Digunakan untuk membentuk header custom yang melengkung ke dalam. |
| `CustomClipper<Path>` | Membuat bentuk lengkungan khusus pada header halaman utama. |

### 2. Tampilan & List

| Widget | Fungsi |
|--------|--------|
| `Text` | Menampilkan teks seperti judul aplikasi, label, deskripsi, dan informasi buku. |
| `Icon` | Menampilkan ikon seperti buku, dark mode, logout, dan lainnya. |
| `Card` | Membungkus setiap item buku agar tampil lebih rapi dan elegan. |
| `ListTile` | Menampilkan informasi utama setiap buku di dalam card. |
| `ListView.builder` | Menampilkan daftar buku secara dinamis berdasarkan data dari Supabase. |
| `FloatingActionButton` | Tombol bulat untuk menambahkan buku baru. |
| `TextFormField` | Digunakan untuk input data pada form login, register, tambah buku, dan edit buku. |
| `ElevatedButton` | Tombol utama untuk login, register, save, dan update. |
| `TextButton` | Tombol ringan untuk aksi seperti batal, hapus, ya, dan tidak. |
| `IconButton` | Tombol berbentuk ikon seperti edit, delete, back, toggle password, dark mode, dan logout. |
| `RichText` | Menampilkan teks dengan gaya berbeda dalam satu baris, seperti “Belum memiliki akun? Register”. |
| `TextSpan` | Bagian dari `RichText` untuk mengatur gaya berbeda pada sebagian teks. |
| `MouseRegion` | Memberikan efek interaktif saat kursor diarahkan ke teks “Register”. |
| `GestureDetector` | Menangkap tap pada teks interaktif seperti “Register”. |
| `CircularProgressIndicator` | Menampilkan loading saat proses login, register, atau simpan data berlangsung. |

### 3. Dialog & Notifikasi

| Widget / Fitur | Fungsi |
|---------------|--------|
| `AlertDialog` | Menampilkan dialog konfirmasi saat menghapus buku dan logout. |
| `Get.dialog()` | Menampilkan dialog konfirmasi menggunakan GetX. |
| `Get.snackbar()` | Menampilkan notifikasi singkat untuk sukses, error, login gagal, register gagal, dan validasi lainnya. |

### 4. State & Tema

| Widget / Fitur | Fungsi |
|---------------|--------|
| `StatefulWidget` | Digunakan pada halaman yang memiliki data yang berubah, seperti HomePage, LoginPage, RegisterPage, dan FormBukuPage. |
| `StatelessWidget` | Digunakan pada widget yang tidak memiliki perubahan state kompleks, seperti `MyApp` dan `WelcomePage`. |
| `setState()` | Digunakan untuk memperbarui tampilan ketika data berubah, seperti loading, hover, dan perubahan form. |
| `GetBuilder` | Digunakan untuk memperbarui tampilan berdasarkan perubahan tema dari `ThemeController`. |
| `ThemeData` | Mengatur tampilan light mode dan dark mode aplikasi. |
| `ThemeMode` | Menentukan mode tema aktif, apakah light atau dark. |
| `SharedPreferences` | Digunakan untuk menyimpan preferensi dark mode/light mode. |

---

## Struktur Proyek

Struktur proyek pada aplikasi ini dibagi agar lebih rapi dan mudah dipahami. Folder `lib` dipisahkan berdasarkan fungsi, yaitu model, service, controller, dan halaman.

```bash
lib/
├── main.dart
├── controllers/
│   └── theme_controller.dart
├── model/
│   └── buku.dart
├── pages/
│   ├── form_buku_page.dart
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── register_page.dart
│   └── welcome_page.dart
├── services/
│   └── buku_service.dart

## Dependencies

| Dependency | Fungsi |
|---------------|--------|
| `get`                | Digunakan untuk navigasi antar halaman, dialog, snackbar, dan state management sederhana. |
| `google_fonts`       | Digunakan untuk mengatur font aplikasi menggunakan font Poppins.                          |
| `supabase_flutter`   | Digunakan untuk integrasi Supabase, baik untuk autentikasi maupun database.               |
| `flutter_dotenv`     | Digunakan untuk membaca konfigurasi rahasia dari file `.env`.                             |
| `shared_preferences` | Digunakan untuk menyimpan status dark mode/light mode secara lokal.                       |

