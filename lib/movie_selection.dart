import 'dart:math';

import 'package:flutter/material.dart';
import 'home.dart';

class MovieSelectionPage extends StatefulWidget {
  const MovieSelectionPage({super.key});

  @override
  State<MovieSelectionPage> createState() => _MovieSelectionPageState();
}

class _MovieSelectionPageState extends State<MovieSelectionPage> {

  List<Map<String, String>> _movies = [
    {'name': 'Pirates of Caribbean', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'The Dark Knight', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'Interstellar', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'Pulp Fiction', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'The Matrix', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'Fight Club', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'The Godfather', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'Forrest Gump', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'The Shawshank Redemption', 'movie_image': 'images/movie_image.jpg'},
    {'name': 'The Lord of the Rings', 'movie_image': 'images/movie_image.jpg'},
  ];

  List<String> _selectedMovies = [];

  void _toggleMovieSelection(String movie) {
    setState(() {
      if (_selectedMovies.contains(movie)) {
        _selectedMovies.remove(movie);
      } else {
        _selectedMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color(0xFF141414),
        title: Text(
          "Pick your favourites...",
          style: TextStyle(
            fontFamily: "alfaSlabOne",
            fontSize: 16,
            color: Color(0xFF2EFE57),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF141414),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220.0,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75, // Aspect ratio of the items
          ),
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            Map<String, String> m = _movies[index];
            String movie = m['name']!;
            String movieImage = m['movie_image']!;
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
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movie,
                        overflow: movie.length>45 ? TextOverflow.ellipsis : TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 1/log(movie.length*10)*42+0.9,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2EFE57),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: const Icon(Icons.check, color: Colors.black),
      ),
    );
  }
}
