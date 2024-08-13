import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: AppBar(
          title: const Text('Filmitivity'),
          backgroundColor: Colors.black,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.normal, color: Color(0xFFFFEED9), fontSize: 27.0, fontFamily: 'alfaSlabOne'),
        ),
        body: const Center(child: Text('It\'s body')),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(color: Color(0xFFFFE085), fontFamily: 'alfaSlabOne'),
          unselectedLabelStyle: const TextStyle(color: Colors.white, fontFamily: 'alfaSlabOne'),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Color(0xFFFF0000)),
              label: 'favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color(0xFFFCC83A)),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Color(0xFFBCBCBC)),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}
