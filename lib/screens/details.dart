// file: lib/screens/detail.dart
import 'package:flutter/material.dart';
import '../models/animals_data.dart';

class DetailPage extends StatelessWidget {
  final Animal animal;

  const DetailPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(animal.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BoxFit.contain menampilkan seluruh gambar tanpa memotong bagian atas atau bawah.
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey.shade200,
                child: Image.network(animal.image, fit: BoxFit.contain),
              ),

              const SizedBox(height: 16),
              const Text(
                'Animal Details:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _DetailBox(label: 'Type', value: animal.type),
                  _DetailBox(label: 'Height', value: '${animal.height}'),
                  _DetailBox(label: 'Weight', value: '${animal.weight}'),
                  _DetailBox(
                    label: 'Habitat',
                    value: animal.habitat.join(', '),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                'Animal Activities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: animal.activities
                    .map((activity) => _ActivityBox(label: activity))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailBox extends StatefulWidget {
  final String label;
  final String value;

  const _DetailBox({required this.label, required this.value});

  @override
  State<_DetailBox> createState() => _DetailBoxState();
}

class _DetailBoxState extends State<_DetailBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
          _isHovered ? widget.value : widget.label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _isHovered ? Colors.deepOrange.shade900 : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _ActivityBox extends StatelessWidget {
  final String label;

  const _ActivityBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
