import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart'; // Import tetap
import 'dart:io';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _result;
  String? _description;
  String? _processingMethod;
  bool _showAdditionalButtons = false;

  @override
  void initState() {
    super.initState();
    _loadModel(); // Memuat model TFLite saat aplikasi dimulai
  }

  Future<void> _loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite", // Lokasi model
      labels: "assets/labels.txt", // Lokasi label
    );
    print("Model Loaded: $res");
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _predictImage(File image) async {
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        String label = recognitions[0]["label"];
        setState(() {
          _result = label;
          _description = _getDescriptionForLabel(label);
          _processingMethod = _getProcessingMethodForLabel(label);
          _showAdditionalButtons = true; // Menampilkan tombol tambahan setelah prediksi
        });
      } else {
        setState(() {
          _result = "tidak terdeteksi";
          _description = null;
          _processingMethod = null;
          _showAdditionalButtons = true; // Menampilkan tombol tambahan jika tidak ada hasil
        });
      }
    } catch (e) {
      print("Error during image prediction: $e");
      setState(() {
        _result = "Error during prediction";
        _description = null;
        _processingMethod = null;
        _showAdditionalButtons = true; // Menampilkan tombol tambahan jika ada error
      });
    }
  }

  String _getDescriptionForLabel(String label) {
    // Gantilah ini dengan deskripsi sesuai label yang diprediksi
    switch (label) {
      case "Label1":
        return "Deskripsi untuk Label1";
      case "Label2":
        return "Deskripsi untuk Label2";
      // Tambahkan lebih banyak deskripsi sesuai dengan label yang mungkin
      default:
        return "Deskripsi tidak tersedia.";
    }
  }

  String _getProcessingMethodForLabel(String label) {
    // Gantilah ini dengan cara pengolahan sesuai label yang diprediksi
    switch (label) {
      case "Label1":
        return "Cara pengolahan untuk Label1";
      case "Label2":
        return "Cara pengolahan untuk Label2";
      // Tambahkan lebih banyak cara pengolahan sesuai dengan label yang mungkin
      default:
        return "Cara pengolahan tidak tersedia.";
    }
  }

  void _showDetailDialog() {
    // Menampilkan dialog dengan detail hasil klasifikasi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detail Hasil Klasifikasi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hasil: $_result"),
              SizedBox(height: 10),
              Text("Deskripsi: $_description"),
              SizedBox(height: 10),
              Text("Cara Pengolahan: $_processingMethod"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close(); // Menutup model TFLite ketika screen ditutup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Color(0xFFD5E9F8),
      appBar: AppBar(
        title: Text('Scan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF378CE7),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text('No image selected')
                  : Image.file(_image!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_image == null) {
                    _showSnackBar(context, "Please select the image");
                  } else {
                    _predictImage(_image!); // Prediksi gambar saat tombol ditekan
                  }
                },
                child: Text(
                  'Scan Now',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF378CE7),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 20),
              _result != null
                  ? Column(
                      children: [
                        Text(
                          'Hasil: Sampah $_result',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: _showDetailDialog,
                              child: Text(
                                'Detail',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF67C6E3),
                                minimumSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                shadowColor: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Logika untuk menyimpan ke history
                                _showSnackBar(context, "Hasil telah disimpan ke history.");
                              },
                              child: Text(
                                'Save to History',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF378CE7),
                                minimumSize: Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                shadowColor: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _getImageFromGallery,
                    child: Text(
                      'Galery',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF378CE7),
                      minimumSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _getImageFromCamera,
                    child: Text(
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF67C6E3),
                      minimumSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        selectedItemColor: Color(0xFF378CE7),
        unselectedItemColor: Color(0xFF67C6E3),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/scan');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/history');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}
