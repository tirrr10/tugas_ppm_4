import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class DetailScreen extends StatelessWidget {
  final TourPackage package;
  const DetailScreen({super.key, required this.package});

  Future<void> _book(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.booking,
      arguments: {'package': package},
    );
    if (result is Map<String, dynamic> &&
        result['success'] == true &&
        context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Pemesanan ${package.title} berhasil dikirim!'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Wisata')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              package.imageUrl,
              height: 230,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 230,
                color: Colors.teal.shade50,
                child: const Icon(
                  Icons.landscape,
                  size: 80,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            package.title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Kode paket: ${package.id}',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 14),
          Text(
            package.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 18),
          Text(
            'Harga: Rp${package.price}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _book(context),
            icon: const Icon(Icons.book_online),
            label: const Text('Pesan Sekarang'),
          ),
        ],
      ),
    );
  }
}
