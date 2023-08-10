import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_api.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/widgets/grid_view.dart';
import 'package:movies_app/helper/api_helper.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  int currentPage = 1;
  List<MovieModel> topRatedMovies = [];
  ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    _fetchTopRatedMovies();
    super.initState();
  }

  void _fetchTopRatedMovies() async {
    final fetchedMovies =
        await apiHelper.fetchMovies(Api.apiTopRatedMovies, currentPage);
        if(mounted){
    setState(() {
      topRatedMovies.addAll(fetchedMovies);
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return 
       Padding(
      
          padding: const EdgeInsets.all(20),
          child: GridViewForMovies(
            movies: topRatedMovies,
            url: Api.apiTopRatedMovies,
            currentPage: currentPage++,
          ));
}
}