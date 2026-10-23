import 'package:flutter/material.dart';

import '../models/tour_package.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  DateTime? departureDate;
  bool dialogOpen = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final now = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (selected != null) {
      setState(() {
        departureDate = selected;
      });
    }
  }

  Future<bool> confirmBack() async {
    if (dialogOpen) return false;

    dialogOpen = true;

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Batalkan Pemesanan?'),
          content: const Text('Data yang sudah diisi tidak akan disimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Lanjut Isi'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    dialogOpen = false;

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    final package = args is Map<String, dynamic>
        ? args['package'] as TourPackage?
        : null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final leave = await confirmBack();

        if (leave && mounted) {
          Navigator.pop(context);
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Booking'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final leave = await confirmBack();

              if (leave && mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),

        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Data Pemesanan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                package?.title ?? 'Paket Wisata',
                style: const TextStyle(fontSize: 18),
              ),

              if (package != null) Text('Harga paket: Rp${package.price}'),

              const SizedBox(height: 25),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 8) {
                    return 'Nomor telepon tidak valid';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: chooseDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  departureDate == null
                      ? 'Pilih Tanggal Keberangkatan'
                      : 'Tanggal: ${departureDate!.day}/'
                            '${departureDate!.month}/'
                            '${departureDate!.year}',
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    if (departureDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Silakan pilih tanggal keberangkatan.'),
                        ),
                      );

                      return;
                    }

                    Navigator.pop(context, {
                      'success': true,
                      'name': nameController.text.trim(),
                      'phone': phoneController.text.trim(),
                      'date': departureDate!.toIso8601String(),
                    });
                  },
                  child: const Text('Kirim Pemesanan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
