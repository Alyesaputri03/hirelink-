import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  final Map<String, dynamic> job; // <-- tambahkan baris ini

  const JobDetailScreen({super.key, required this.job}); // <-- ubah constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Lowongan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'Upload/Edit Gambar di Sini',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              job['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(job['location'], style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              'Gaji: ${job['salary']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi Pekerjaan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ini adalah deskripsi lengkap dari pekerjaan yang ditawarkan. Anda akan bekerja bersama tim profesional dan mendapatkan fasilitas yang mendukung perkembangan karier Anda.',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Daftar Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
