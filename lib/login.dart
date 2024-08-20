import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: const Color(0xFF000000),
                elevation: 8,
                shadowColor: const Color(0xFF0A0A0A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
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
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: const Color(0xFFCCFEF0),
                        style: const TextStyle(color: Color(0xFFCCFEF0)),
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFFFEED9),
                            fontFamily: 'alfaSlabOne',
                          ),
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFCCFEF0),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        cursorColor: const Color(0xFFCCFEF0),
                        style: const TextStyle(color: Color(0xFFFFEED9)),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFFFEED9),
                            fontFamily: 'alfaSlabOne',
                          ),
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFCCFEF0),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2EFE57), Color(0xFFA3FFE9)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Navigate to HomeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.transparent, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            backgroundColor: Colors.transparent, // Text color
                          ),
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF2EFE57), Color(0xFFA3FFE9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'alfaSlabOne',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
