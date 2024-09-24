import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'movie_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> _selectedGenres = [];
  List<String> _genres = [];
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('genres').get();
      setState(() {
        _genres = snapshot.docs.map((doc) => doc['name'] as String).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching genres: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleGenreSelection(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'email': _emailController.text,
        'username': _usernameController.text,
        'age': _ageController.text,
        'genres': _selectedGenres,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MovieSelectionPage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

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
                child: Container(
                  width: 380,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                    Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('images/logo.png', width: 45, height: 45),
                      const SizedBox(width: 5),
                      const Text(
                        'Filmitivity',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'alfaSlabOne',
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: const Color(0xFF39FF14),
                        style: const TextStyle(color: Color(0xFF39FF14)),
                        decoration: InputDecoration(
                          hintText: 'Email',
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
                              color: Color(0xFF39FF14),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        cursorColor: const Color(0xFF39FF14),
                        style: const TextStyle(color: Color(0xFF39FF14)),
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
                              color: Color(0xFF39FF14),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ageController,
                        cursorColor: const Color(0xFF39FF14),
                        style: const TextStyle(color: Color(0xFF39FF14)),
                        decoration: InputDecoration(
                          hintText: 'Age',
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
                              color: Color(0xFF39FF14),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        cursorColor: const Color(0xFF39FF14),
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
                              color: Color(0xFF39FF14),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const Text("")
                          : Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: _genres.map((genre) {
                          bool isSelected = _selectedGenres.contains(genre);
                          return GestureDetector(
                            onTap: () => _toggleGenreSelection(genre),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF2EFE57) : const Color(0xFF242424),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                genre,
                                style: TextStyle(
                                  color: isSelected ? Colors.black : const Color(0xFFFFFFFF),
                                  fontSize: 14,
                                  fontFamily: 'alfaSlabOne',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'alfaSlabOne',
                          ),
                        ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF39FF14),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: _signUp,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            backgroundColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'alfaSlabOne',
                              fontSize: 18,
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
