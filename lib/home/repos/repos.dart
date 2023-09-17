import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_movie_app_with_bloc/model/movies_data_model.dart';

class Repos {
  static Future<List<Result>> fetchMovieData() async {
    const String apiUrl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=db0dcf6a517e0074f03f43ddc49031b4';
    print('data fetching');

    final response = await http.get(Uri.parse(apiUrl));
    final List results = jsonDecode(response.body)['results'];
    print('data fetched');
    return results.map((e) => Result.fromJson(e)).toList();
  }
}
