import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'models/Movie.dart';

class MovieSelectionPage extends StatefulWidget {
  const MovieSelectionPage({super.key});

  @override
  State<MovieSelectionPage> createState() => _MovieSelectionPageState();
}

class _MovieSelectionPageState extends State<MovieSelectionPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Future<List<Movie>> future_movies;
  List<String> _selectedMovies = [];

  Future<List<Movie>> fetchMovieSelectionList() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/selection-list/20'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Movie> movies = Movie.fromJsonList(jsonList);
      return movies;
    } else {
      throw Exception("Failed to load movie selection list");
    }
  }

  void _toggleMovieSelection(String movie) {
    setState(() {
      if (_selectedMovies.contains(movie)) {
        _selectedMovies.remove(movie);
      } else {
        _selectedMovies.add(movie);
      }
    });
  }

  Future<void> _saveSelectedMovies() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'favourites': _selectedMovies,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } catch (e) {
      print("Failed to save movies: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    future_movies = fetchMovieSelectionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          "Pick your favourites...",
          style: TextStyle(
            fontFamily: "alfaSlabOne",
            fontSize: 16,
            color: Color(0xFF2EFE57),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF141414),
      body: FutureBuilder<List<Movie>>(
        future: future_movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found.'));
          } else {
            List<Movie> movies = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie m = movies[index];
                  String movie = m.title;
                  String movieImage = "images/logo.png"; // Ensure you have this image
                  final isSelected = _selectedMovies.contains(movie);

                  return GestureDetector(
                    onTap: () {
                      _toggleMovieSelection(movie);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2EFE57) : const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              movieImage,
                              width: double.infinity,
                              height: 185,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 1 / log(movie.length * 10) * 42 + 0.9,
                                fontFamily: 'alfaSlabOne',
                                color: isSelected ? const Color(0xFF000000) : const Color(0xFFFFEED9),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2EFE57),
        onPressed: _saveSelectedMovies,
        child: const Icon(Icons.check, color: Colors.black),
      ),
    );
  }
}
