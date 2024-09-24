import 'dart:convert';
import 'package:android01/profile.dart';
import 'package:android01/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'about.dart';
import 'login.dart';
import 'models/Movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<List<Movie>> future_favorite_movies;
  late Future<List<Movie>> future_movies;

  Future<List<Movie>> fetchFavorites() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("No user is logged in");
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    if (!userDoc.exists) {
      throw Exception("User document does not exist");
    }

    List<String> favoriteTitles = List<String>.from(userDoc['favourites']);
    List<Movie> favoriteMovies = [];

    for (String title in favoriteTitles) {
      try {
        final response = await http.get(Uri.parse('http://127.0.0.1:5000/getMovie/$title'));
        if (response.statusCode == 200) {
          List<dynamic> jsonList = json.decode(response.body);
          List<Movie> movies = jsonList.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
          favoriteMovies.add(movies[0]);
        } else {
          print('Failed to fetch movie details for $title');
        }
      } catch (e) {
        print('Error fetching movie details for $title: $e');
      }
    }

    return favoriteMovies;
  }

  Future<List<Movie>> fetchMovieRecommendations(List<Movie> fav) async {
    Set<String> seenTitles = {};
    List<Movie> recs = [];

    for (Movie m in fav) {
      String title = m.title;
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/recommend/$title/3'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Movie> movies = Movie.fromJsonList(jsonList);
        for (Movie movie in movies) {
          if (!seenTitles.contains(movie.title)) {
            seenTitles.add(movie.title);
            recs.add(movie);
          }
        }
      } else {
        throw Exception("Failed to load movie suggestions...");
      }
    }

    return recs;
  }

  void _removeFromFavourites(Movie movie) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
        'favourites': FieldValue.arrayRemove([movie.title]),
      });

      // Refresh the favorites list
      setState(() {
        future_favorite_movies = fetchFavorites();
        future_movies = future_favorite_movies.then((favorites) async {
          return fetchMovieRecommendations(favorites);
        });
      });
    } catch (e) {
      print('Error removing movie from Firestore: $e');
    }
  }

  void _onBottomAppBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    future_favorite_movies = fetchFavorites();
    future_movies = future_favorite_movies.then((favorites) async {
      return fetchMovieRecommendations(favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
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
            ? FutureBuilder<List<Movie>>(
          future: future_movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No movies found.', style: TextStyle(color: Colors.white,
                  fontFamily: 'alfaSlabOne')));
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
                    Movie movie = movies[index];
                    String movieImage = "images/logo.png";

                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
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
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 1 / log(movie.title.length * 10) * 42 + 0.9,
                                fontFamily: 'alfaSlabOne',
                                color: const Color(0xFFFFEED9),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        )
            : _selectedIndex == 1
            ? FutureBuilder<List<Movie>>(
          future: future_favorite_movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No favorite movies found.'));
            } else {
              List<Movie> movies = snapshot.data!;
              return Container(
                decoration: BoxDecoration(color: const Color(0xFF131313)),
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    Movie movie = movies[index];
                    String movieImage = "images/logo.png";
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 1 / log(movie.title.length * 10) * 42 + 0.9,
                                    fontFamily: 'alfaSlabOne',
                                    color: const Color(0xFFFFEED9),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeFromFavourites(movie),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        )
            : _selectedIndex == 2
            ? const Text("Search")
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
      endDrawer:
    Drawer(
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
                fontFamily: 'AlfaSlabOne',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_rounded, color: Color(0xFFFFEED9)),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Color(0xFFFFEED9),
                fontFamily: 'AlfaSlabOne',
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
            leading: const Icon(Icons.logout_outlined, color: Color(0xFFFFEED9)),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFFFEED9),
                fontFamily: 'AlfaSlabOne',
              ),
            ),
            onTap: () async {
              // Log out logic
              await FirebaseAuth.instance.signOut();

              // Navigate to login page and show "Successfully logged out" message
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(
                    showLogoutMessage: true,
                  ),
                ),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFFFFEED9)),
            title: const Text(
              'About',
              style: TextStyle(
                color: Color(0xFFFFEED9),
                fontFamily: 'AlfaSlabOne',
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
    )
    );
  }
}