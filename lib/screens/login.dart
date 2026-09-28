// file: lib/screens/login.dart
import 'package:flutter/material.dart';
import 'home_page.dart';

// Key ini membuat SnackBar tetap dapat ditampilkan walaupun halaman login diganti.
final GlobalKey<ScaffoldMessengerState> appScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Widget halaman login yang menjadi halaman awal aplikasi.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk membaca nilai username dari TextField.
  final TextEditingController _usernameController = TextEditingController();

  // Controller untuk membaca nilai password dari TextField.
  final TextEditingController _passwordController = TextEditingController();

  // State untuk mengubah warna input ketika login gagal.
  bool isLoginFailed = false;

  @override
  void dispose() {
    // Membersihkan controller ketika halaman login tidak lagi digunakan.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Memeriksa kredensial lalu mengarahkan user ke halaman home jika benar.
  void _handleLogin() {
    // Mengambil teks yang dimasukkan user pada kedua field.
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Sesuaikan nilai ini dengan NIM dan nama prodi yang ditentukan pada tugas.
    if (username == "124240144" && password == "Sistem Informasi") {
      // Menghapus status gagal sebelum berpindah halaman.
      setState(() {
        isLoginFailed = false;
      });

      // Menghapus login dari stack agar tombol kembali tidak kembali ke login.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

      // Menampilkan pemberitahuan bahwa login berhasil pada halaman baru.
      appScaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Login berhasil'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Menandai input sebagai salah agar garis field berubah menjadi merah.
      setState(() {
        isLoginFailed = true;
      });

      // Memberi informasi kepada user ketika kredensial tidak sesuai.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal: Username atau Password salah'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar dan warna latar halaman login.
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F7),
      // Scroll mencegah form tertutup keyboard pada layar yang pendek.
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            // ConstrainedBox menjaga lebar form tetap nyaman di layar besar.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 6,
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Judul membantu user mengenali tujuan halaman.
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Field username menggunakan NIM sebagai kredensial login.
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: const OutlineInputBorder(),
                          // Garis berubah merah ketika kredensial salah.
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isLoginFailed ? Colors.red : Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isLoginFailed ? Colors.red : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Field password menggunakan nama prodi dan menyembunyikan input.
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isLoginFailed ? Colors.red : Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isLoginFailed ? Colors.red : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tombol menjalankan proses validasi login.
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
