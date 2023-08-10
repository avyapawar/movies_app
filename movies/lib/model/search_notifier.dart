import 'package:flutter/material.dart';
import 'package:movies_app/helper/api_helper.dart';
import 'package:movies_app/model/movie_model.dart';

class SearchNotifier extends ChangeNotifier {
   static final SearchNotifier _instance = SearchNotifier._internal();

  factory SearchNotifier() => _instance;

  SearchNotifier._internal();

  String searchedData = '';
  bool isSearching = false;
  bool isLoader = false ;
  bool hasData = true ;
  List<MovieModel> searchedMovie = [];
   ApiHelper fetchMovieHepler = ApiHelper() ;



  Future<void> updateSearchData(String value) async {
    searchedData = value;
    isSearching = value.isNotEmpty;
    notifyListeners();

 if (isSearching) {
   hasData = true ;
     notifyListeners();

   fetchMovieHepler.isSearchingError= false ;
       searchedMovie = await fetchMovieHepler.getSearchedResults(enteredMovieName: searchedData ,currentPage: 1); 
       if(searchedMovie.length < 10 ){
 isSearching = false ;

       }
       if(searchedMovie.isEmpty){
      hasData = false ;
       }
     notifyListeners();
    
    }
    
  }

  void clearSearchData() {
    searchedData = '';
    isSearching = false;
    isLoader = false ;
    searchedMovie.clear();
    notifyListeners();
  }
 Future< void> onScrollFetchSearchedMovies(String searchData ,int c)async {
 if (!isSearching) {
  isLoader = false ;
  notifyListeners() ;
      return;
    }
    isLoader= true;
  notifyListeners() ;

    final fetchMovies = await fetchMovieHepler.getSearchedResults(
      enteredMovieName: searchData,
      currentPage: c,
    );
    isLoader= false ;
  notifyListeners() ;

    if (fetchMovies.isEmpty) {
      isSearching = false; 
      isLoader =false  ; 
    } else {
      c++ ;
      searchedMovie.addAll(fetchMovies);
    }

    notifyListeners();
  }

   
   
  
  }
