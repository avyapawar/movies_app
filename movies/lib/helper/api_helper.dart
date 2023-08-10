import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/constant/const_api.dart';
import 'package:movies_app/model/cast_model.dart';
import 'package:movies_app/model/movie_detail_model.dart';
import 'package:movies_app/model/movie_model.dart';

class ApiHelper with ChangeNotifier{
  static final ApiHelper _instance = ApiHelper._internal();
  factory ApiHelper() => _instance;
  ApiHelper._internal();
  bool? isSearchingError ;
  bool? isFetchingMoviesError ;

  Future<List<MovieModel>> fetchMovies(String url, int currentPage) async {
      isFetchingMoviesError = false ;
    try{
       final response = await http.get(Uri.parse('$url&page=$currentPage'));
   
      final reponsedata = jsonDecode(response.body);
      final List<dynamic> photosData = reponsedata['results'];
      final photos =
          photosData.map((data) => MovieModel.fromJson(data)).toList();
      return photos;
  
    }catch(e){
     isFetchingMoviesError = true ;
        return [] ;
    }
   
  }

  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
    
    final response = await http
        .get(Uri.parse('${Api.baseUrl}$movieId?api_key=${Api.apiKey}'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return MovieDetailModel.fromJson(jsonData);
    } else {
      throw Exception('error');
    }
  }

  Future<List<Cast>> fetchCastList(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${Api.apiKey}&language=en-US'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> castData = jsonData['cast'];
      List<Cast> castList =
          castData.map((item) => Cast.fromJson(item)).toList();
      return castList;
    } else {
      throw Exception('Failed to load cast list');
    }
  }

   Future<List<MovieModel>> getSearchedResults({required String enteredMovieName, required int currentPage}) async {
    isSearchingError = false ;

    try {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=${Api.apiKey}&language=en-US&query=$enteredMovieName&page=$currentPage'));
 final reponsedata = jsonDecode(response.body);
      final List<dynamic> photosData = reponsedata['results'];
      final photos =
          photosData.map((data) => MovieModel.fromJson(data)).toList();
      return photos;
    }catch(e){
      isSearchingError = true ;
      return [] ;
    }
  
  }
}
