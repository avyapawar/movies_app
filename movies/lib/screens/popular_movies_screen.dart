import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_api.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/widgets/grid_view.dart';
import 'package:movies_app/helper/api_helper.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});
  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  int currentPage = 1;
  List<MovieModel> popularMovies = [];
  ApiHelper fetchMovieHepler = ApiHelper();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    _fetchPopularMovies();
    super.initState();
  }

  void _fetchPopularMovies() async {
    try {
      final fetchedMovies =
          await fetchMovieHepler.fetchMovies(Api.apiPopularMovies, currentPage);
      setState(() {
        popularMovies.addAll(fetchedMovies);
      });
    } catch (e) {
      if (popularMovies.isEmpty) {
        setState(() {
          fetchMovieHepler.isFetchingMoviesError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridViewForMovies(
      movies: popularMovies,
      url: Api.apiPopularMovies,
      currentPage: currentPage++,
    );
  }
}
