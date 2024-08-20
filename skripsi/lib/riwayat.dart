import 'package:flutter/material.dart';

class RiwayatScanPage extends StatelessWidget {
  // Contoh data riwayat scan dengan waktu dan tanggal
  final List<Map<String, String>> riwayatScan = [
    {
      'foto': 'assets/organik.jpg',
      'nama': 'Sampah Organik 1',
      'kategori': 'Organik',
      'deskripsi': 'Sampah organik seperti sisa makanan dan daun.',
      'penanganan': 'Komposkan atau buang ke tempat sampah organik.',
      'tanggal': '2024-07-18',
      'waktu': '14:30'
    },
    {
      'foto': 'assets/anorganik.jpg',
      'nama': 'Sampah Anorganik 1',
      'kategori': 'Anorganik',
      'deskripsi': 'Sampah anorganik seperti plastik dan logam.',
      'penanganan': 'Daur ulang atau buang ke tempat sampah anorganik.',
      'tanggal': '2024-07-19',
      'waktu': '09:15'
    },
    {
      'foto': 'assets/b3.jpg',
      'nama': 'Sampah B3 1',
      'kategori': 'B3',
      'deskripsi': 'Sampah berbahaya seperti baterai dan bahan kimia.',
      'penanganan': 'Buang di tempat pembuangan sampah khusus B3.',
      'tanggal': '2024-07-20',
      'waktu': '17:45'
    },
  ];

  void _showDetail(BuildContext context, Map<String, String> scan) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
          title: Text(
            scan['nama']!,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  scan['foto']!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8),
                Text(
                  'Kategori: ${scan['kategori']}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Deskripsi: ${scan['deskripsi']}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cara Penanganan: ${scan['penanganan']}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tanggal: ${scan['tanggal']}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Waktu: ${scan['waktu']}',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: isDarkMode ? Colors.blueAccent : Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF378CE7),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Color(0xFFD5E9F8),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: riwayatScan.length,
          itemBuilder: (context, index) {
            final scan = riwayatScan[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.blueAccent,
              elevation: 5, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => _showDetail(context, scan),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      scan['foto']!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scan['nama']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${scan['waktu']} | ${scan['tanggal']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white70 : Colors.white,
                            ),
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
      ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
        showSelectedLabels: true, 
        showUnselectedLabels: true, 
        selectedLabelStyle: TextStyle(fontSize: 12), 
        unselectedLabelStyle: TextStyle(fontSize: 12), 
        selectedIconTheme: IconThemeData(size: 24), 
        unselectedIconTheme: IconThemeData(size: 24), 
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
