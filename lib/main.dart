import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

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
    // You can add specific actions for each tab here.
    switch (index) {
      case 0:
        print("Home tapped");
        break;
      case 1:
        print("Favourites tapped");
        break;
      case 2:
        print("Search tapped");
        break;
      case 3:
        print("Profile tapped");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        shadowColor: const Color(0xFF131313),
        title: Row(
          children: [
            Image.asset('images/logo.png',width: 45, height: 45),
            const SizedBox(width: 5),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00FF00), Color(0xFFFFF587)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Filmitivity',
                style: TextStyle(
                  color: Colors.white, // This will be overridden by the shader
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
            ? Container(
          color: const Color(0xFF141414),
        )
            : _selectedIndex == 1
            ? const Text("Not Home")
            : const SizedBox(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF131313),
              blurRadius: 8,
            )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: const Color(0xFFFFEED9),
          selectedFontSize: 18,
          unselectedFontSize: 14,
          selectedItemColor: const Color(0xFF00FF00),
          selectedLabelStyle: const TextStyle(
            color: Color(0xFF00FF00),
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
              icon: Icon(Icons.account_circle_rounded, color: Color(0xFFFFEED9)),
              label: 'profile',
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
              leading: const Icon(Icons.settings, color: Color(0xFFFFEED9)),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xFFFFEED9),
                  fontFamily: 'alfaSlabOne',
                ),
              ),
              onTap: () {
                // Handle settings tap
                Navigator.pop(context);
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
                // Handle about tap
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
