import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skripsi/account.dart';
import 'splash_screen.dart';
import 'api_manager.dart';
import 'login.dart';
import 'register.dart';
import 'homepage.dart';
import 'scan.dart';
import 'setting.dart';
import 'riwayat.dart';
import 'user_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final ApiManager apiManager = ApiManager(baseUrl: 'http://127.0.0.1:8000/api');

  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserManager()),
        Provider.value(value: apiManager),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Smart Waste',
            theme: isDarkMode
                ? ThemeData.dark().copyWith(
                    primaryColor: Color(0xFF378CE7),
                  )
                : ThemeData.light().copyWith(
                    primaryColor: Color(0xFF378CE7),
                  ),
            home: SplashScreen(),
            routes: {
              '/login': (context) => LoginScreen(apiManager: ApiManager(baseUrl: baseUrl)),
              '/register': (context) => RegisterScreen(apiManager: ApiManager(baseUrl: baseUrl)),
              '/scan': (context) => ScanScreen(),
              '/home': (context) => HomePage(),
              '/settings': (context) => SettingsPage(
                    isDarkMode: isDarkMode,
                    toggleDarkMode: toggleDarkMode,
                  ),
              '/history': (context) => RiwayatScanPage(),
              '/account': (context) => AccountPage(),
            },
          );
        },
      ),
    );
  }
}
