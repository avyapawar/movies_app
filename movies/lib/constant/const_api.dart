class Api{
   Api();
  //  https:api.themoviedb.org/3/movie/popular?api_key=c45a857c193f6302f2b5061c3b85e743&language=en-US&page=1
  static const String baseUrl= 'https://api.themoviedb.org/3/movie/' ;
 static const String apiKey = 'c45a857c193f6302f2b5061c3b85e743' ;
 static const String apiPopularMovies = '${baseUrl}popular?api_key=$apiKey&language=en-US' ;
 static const String apiTopRatedMovies = '${baseUrl}top_rated?api_key=$apiKey&language=en-US' ;
  static const String apiUpcomingMovies = '${baseUrl}upcoming?api_key=$apiKey&language=en-US' ;
}


