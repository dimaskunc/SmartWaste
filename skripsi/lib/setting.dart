import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_manager.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final Function toggleDarkMode;

  SettingsPage({
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF378CE7),
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Color(0xFFD5E9F8),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
              ),
              trailing: Icon(Icons.account_circle, color: isDarkMode ? Colors.white : Colors.black),
              onTap: () {
                Navigator.pushNamed(context, '/account');
              },
            ),
            Divider(color: isDarkMode ? Colors.white : Colors.black),
            ListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
              ),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
                activeColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Divider(color: isDarkMode ? Colors.white : Colors.black),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
              ),
              trailing: Icon(Icons.logout, color: isDarkMode ? Colors.white : Colors.black),
              onTap: () async {
                final userManager = Provider.of<UserManager>(context, listen: false);
                await userManager.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
