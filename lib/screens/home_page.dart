// file: lib/screens/home_page.dart
import 'package:flutter/material.dart';

// Sesuaikan path import ini jika model atau nama file sumber data berada di folder lain.
// Jika studi kasus memakai model berbeda, ganti Animal dengan nama class model tersebut.
import '../models/animals_data.dart';

// Sesuaikan path dan nama class ini jika halaman tujuan memiliki nama file atau class berbeda.
import 'details.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animals List'),
        backgroundColor: const Color.fromARGB(255, 154, 72, 33),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        // Ubah crossAxisCount untuk menentukan jumlah kolom sesuai jenis data dan ukuran layar.
        // childAspectRatio dapat disesuaikan jika isi kartu lebih pendek atau lebih panjang.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
        ),
        // Ganti dummyAnimals dengan list data lain, misalnya products atau users.
        // Pastikan list tersebut memiliki tipe data yang sesuai dengan model di bawah.
        itemCount: dummyAnimals.length, // Gunakan dummyAnimals
        itemBuilder: (context, index) {
          // Ganti Animal dan dummyAnimals[index] jika studi kasus menggunakan model berbeda.
          final Animal animal = dummyAnimals[index];

          return GestureDetector(
            onTap: () {
              // Ganti DetailPage dan parameter animal jika halaman detail atau nama parameternya berbeda.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(animal: animal),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  // Bagian ini cocok untuk URL gambar. Jika gambar berasal dari asset lokal,
                  // gunakan Image.asset dan sesuaikan path asset pada pubspec.yaml.
                  // Gunakan BoxFit.contain agar seluruh gambar terlihat dan tidak terpotong.
                  // Jika BoxFit.cover digunakan, gambar akan memenuhi kotak tetapi bagian
                  // yang melebihi rasio kotak dapat terpotong.
                  Container(
                    width: double.infinity,
                    height: 120,
                    color: Colors.grey.shade200,
                    child: Image.network(animal.image, fit: BoxFit.contain),
                  ),
                  // Ganti animal.name dan animal.type sesuai nama properti pada model studi kasus.
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animal.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Tipe ditampilkan langsung tanpa label tambahan.
                        Text(
                          animal.type,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 8),
                        // Ganti animal.habitat dengan properti list yang sesuai pada model lain.
                        // Setiap nilai habitat ditampilkan sebagai kotak kecil yang terpisah.
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: animal.habitat
                              .map((habitat) => _HabitatChip(label: habitat))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Widget habitat yang memiliki animasi sederhana ketika terkena hover.
class _HabitatChip extends StatefulWidget {
  // Teks habitat yang ditampilkan di dalam kotak.
  final String label;

  // Membuat chip habitat berdasarkan nama habitat dari data hewan.
  const _HabitatChip({required this.label});

  @override
  State<_HabitatChip> createState() => _HabitatChipState();
}

// State ini menyimpan apakah kursor sedang berada di atas chip.
class _HabitatChipState extends State<_HabitatChip> {
  // Nilai ini hanya berpengaruh pada perangkat yang mendukung hover.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // MouseRegion mendeteksi kursor tanpa mengubah perilaku tap pada kartu.
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.orange.shade100 : Colors.white,
          border: Border.all(
            color: _isHovered ? Colors.deepOrange : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.deepOrange.withValues(alpha: 0.25),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : const [],
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? Colors.deepOrange.shade900 : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
