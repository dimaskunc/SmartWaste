import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'assets/corousel1.png',
    'assets/corousel2.png',
    'assets/corousel3.png',
    'assets/corousel4.png',
  ];

  String? _selectedCategoryDescription;

  void _updateDescription(String description) {
    setState(() {
      _selectedCategoryDescription = description;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black 
          : Color(0xFFD5E9F8),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF378CE7),
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, ${userManager.username ?? 'User'}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imgList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 8.0, right: 8.0), 
                          child: Image.asset(
                            imgList[index],
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 32, 
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryButton(
                        title: 'Organik',
                        color: Colors.green,
                        onPressed: () => _updateDescription(
                          'Sampah organik adalah jenis sampah yang berasal dari bahan-bahan yang mudah terurai oleh mikroorganisme menjadi senyawa yang lebih sederhana. Sampah organik biasanya berasal dari makhluk hidup, seperti tumbuhan dan hewan. Berikut adalah beberapa karakteristik utama dari sampah Organik:\n'
                          '1. Biodegradable\n'
                          '2. Berbau\n'
                          '3. Berat dan Basah\n'),
                      ),
                      CategoryButton(
                        title: 'Anorganik',
                        color: Colors.yellow,
                        onPressed: () => _updateDescription(
                          'Sampah anorganik adalah jenis sampah yang berasal dari bahan-bahan yang tidak mudah terurai oleh mikroorganisme. Sampah anorganik biasanya terdiri dari material yang dibuat oleh manusia atau berasal dari mineral. Berikut adalah beberapa karakteristik utama dari sampah Anorganik:\n'
                          '1. Non-Biodegradable\n'
                          '2. Tahan lama\n'
                          '3. Dapat didaur ulang\n'),
                      ),
                      CategoryButton(
                        title: 'B3',
                        color: Colors.red,
                        onPressed: () => _updateDescription(
                          'Sampah B3 adalah singkatan dari sampah Bahan Berbahaya dan Beracun. Sampah B3 adalah jenis sampah yang mengandung zat-zat yang berpotensi membahayakan kesehatan manusia, makhluk hidup lainnya, atau merusak lingkungan. Berikut adalah beberapa karakteristik utama dari sampah B3:\n'
                          '1. Beracun\n'
                          '2. Reaktif\n'
                          '3. Korosif\n'
                          '4. Imflamable\n'
                          '5. Infeksius\n'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: constraints.maxHeight - 352, 
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _selectedCategoryDescription != null
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _selectedCategoryDescription!,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                                textAlign: TextAlign.justify,
                              ),
                            )
                          : Text(
                              'Pilih kategori untuk melihat deskripsi',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black // Warna background saat mode gelap
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

class CategoryButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  CategoryButton({required this.title, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: Colors.white), 
      ),
      style: ElevatedButton.styleFrom(
        primary: color, 
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(100, 50), 
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 5,
      ),
    );
  }
}
