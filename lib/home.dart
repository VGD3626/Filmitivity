import 'package:android01/profile.dart';
import 'package:android01/settings.dart';
import 'package:flutter/material.dart';

import 'about.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onBottomAppBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        automaticallyImplyLeading: false,
        shadowColor: const Color(0xFF131313),
        title: Row(
          children: [
            Image.asset('images/logo.png', width: 45, height: 45),
            const SizedBox(width: 5),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF2EFE57), Color(0xFFA3FFE9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Filmitivity',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'alfaSlabOne',
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 22.0,
        ),
      ),
      body: Center(
        child: _selectedIndex == 0
            ? Container(color: const Color(0xFF131313)) // Home screen content
            : _selectedIndex == 1
            ? const Text("Favourites") // Replace with actual Favourites content
            : _selectedIndex == 2
            ? const Text("Search") // Replace with actual Search content
            : const SizedBox(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF090909),
              blurRadius: 8,
            )
          ],
        ),
        child: BottomNavigationBar(
          elevation: 8,
          backgroundColor: Colors.black,
          unselectedItemColor: const Color(0xFFFFEED9),
          selectedFontSize: 18,
          unselectedFontSize: 14,
          selectedItemColor: const Color(0xFF2EFE57),
          selectedLabelStyle: const TextStyle(
            color: Color(0xFF2EFE57),
            fontFamily: 'alfaSlabOne',
          ),
          unselectedLabelStyle: const TextStyle(
            color: Color(0xFFFFEED9),
            fontFamily: 'alfaSlabOne',
          ),
          currentIndex: _selectedIndex,
          onTap: _onBottomAppBarItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xFFFFEED9)),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Color(0xFFFFEED9)),
              label: 'favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color(0xFFFFEED9)),
              label: 'search',
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Color(0xFFFFEED9),
                  fontSize: 24,
                  fontFamily: 'alfaSlabOne',
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_rounded, color: Color(0xFFFFEED9)),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xFFFFEED9),
                  fontFamily: 'alfaSlabOne',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFFFEED9)),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xFFFFEED9),
                  fontFamily: 'alfaSlabOne',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Color(0xFFFFEED9)),
              title: const Text(
                'About',
                style: TextStyle(
                  color: Color(0xFFFFEED9),
                  fontFamily: 'alfaSlabOne',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
