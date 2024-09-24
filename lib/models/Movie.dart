class Movie {
  final int id;
  final String title;
  final double popularity;
  final double voteAverage;
  final String genres;
  final String cast;
  final String director;
  final String overview;

  const Movie({
    required this.id,
    required this.title,
    required this.popularity,
    required this.voteAverage,
    required this.genres,
    required this.cast,
    required this.director,
    required this.overview
  });

  // Single Movie object from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      popularity: json['popularity'],
      voteAverage: json['vote_average'].toDouble(),
      genres: json['genres'] != null ? json['genres'] as String : '',
      cast: json['cast'] != null ? json['cast'] as String : '',
      director: json['director'] != null ? json['director'] as String : '',
      overview: json['overview'],
    );
  }

  static List<Movie> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Movie.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'popularity': popularity,
      'vote_average': voteAverage,
      'genres': genres,
      'cast': cast,
      'director': director,
      'overview': overview,
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<Movie> movies) {
    return movies.map((movie) => movie.toJson()).toList();
  }
}
