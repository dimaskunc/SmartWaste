import 'package:flutter/material.dart';
import 'dart:io';

class HasilScanSampah extends StatelessWidget {
  final File image;
  final String namaSampah;
  final String kategoriSampah;
  final String deskripsiSampah;
  final String caraPenanganan;

  HasilScanSampah({
    required this.image,
    required this.namaSampah,
    required this.kategoriSampah,
    required this.deskripsiSampah,
    required this.caraPenanganan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Scan Sampah'),
        backgroundColor: Color(0xFF378CE7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar
            Center(
              child: Image.file(
                image,
                height: 200, // Sesuaikan ukuran gambar sesuai kebutuhan
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan nama sampah
            Text(
              'Nama Sampah: $namaSampah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Menampilkan kategori sampah
            Text(
              'Kategori Sampah: $kategoriSampah',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Menampilkan deskripsi sampah
            Text(
              'Deskripsi Sampah: $deskripsiSampah',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Menampilkan cara penanganan
            Text(
              'Cara Penanganan: $caraPenanganan',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
