import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_api.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/widgets/grid_view.dart';
import 'package:movies_app/helper/api_helper.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  int currentPage = 1;
  List<MovieModel> upcomingMovies =  [];
  ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    _fetchUpcomingMovies();
    super.initState();
  }

  void _fetchUpcomingMovies() async {
    final fetchedMovies =
        await apiHelper.fetchMovies(Api.apiUpcomingMovies, currentPage);
    setState(() {
      upcomingMovies.addAll(fetchedMovies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
       Padding(
          padding: const EdgeInsets.all(20),
          child: GridViewForMovies(
            movies: upcomingMovies,
            url: Api.apiUpcomingMovies,
            currentPage: currentPage++,
          ));
  
  }
}
