// file: lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login.dart';

// Fungsi utama yang menjalankan aplikasi Flutter.
void main() {
  runApp(const MyApp());
}

// Widget root yang mengatur konfigurasi aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp menyediakan tema, judul, dan halaman awal aplikasi.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Hewan',
      // Key ini menjaga SnackBar sukses tetap tampil setelah navigasi login.
      scaffoldMessengerKey: appScaffoldMessengerKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      // Halaman pertama yang ditampilkan adalah LoginPage.
      home: const LoginPage(),
    );
  }
}
