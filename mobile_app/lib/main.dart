import 'package:flutter/material.dart';
import 'package:digital_business_card/screens/home_screen.dart';
import 'package:digital_business_card/screens/qr_scanner_screen.dart';
import 'package:digital_business_card/screens/profile_screen.dart';
import 'package:digital_business_card/screens/my_card_screen.dart';

void main() {
  runApp(const DigitalBusinessCardApp());
}

class DigitalBusinessCardApp extends StatelessWidget {
  const DigitalBusinessCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '數位名片',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'PingFang SC',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const QRScannerScreen(),
    const MyCardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: '掃描',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: '我的名片',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '個人資料',
          ),
        ],
      ),
    );
  }
}
