import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_color.dart';
import 'package:movies_app/constant/const_default_image.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/screens/detail_screen.dart';
import 'package:movies_app/helper/api_helper.dart';
import 'package:movies_app/widgets/loader.dart';

// ignore: must_be_immutable
class GridViewForMovies extends StatefulWidget {
  GridViewForMovies(
      {super.key,
      required this.movies,
      required this.url,
      required this.currentPage});
  final List<MovieModel> movies;
  String url;
  int currentPage;
  @override
  State<GridViewForMovies> createState() => _GridViewForMoviesState();
}

class _GridViewForMoviesState extends State<GridViewForMovies> {
  ScrollController scrollController = ScrollController();
  ApiHelper apiHelper = ApiHelper();
  bool isLoader = false ;

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() async {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0) {
        setState(() {
          isLoader = true ;
        });
        final fetchMovies =
            await apiHelper.fetchMovies(widget.url, widget.currentPage);
        widget.currentPage++;
        setState(() {
          widget.movies.addAll(fetchMovies);
          isLoader = false ;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    void onTapImage(MovieModel movie) {
      setState(() {
         Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailScreen(movie: movie);
      }));
      });
     
    }

    final childAspectFactor = size.width < 1200 ? 1.0 : 1.35;
      if(apiHelper.isFetchingMoviesError!){
   return  Center(
              child:    Container(
                color: Colors.red,
                child:const  Text("oops no internate !...")), 
            );
 }else{
    return 
      Stack(
        children: [GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size.width < 750
                  ? 2
                  : size.width > 750 && size.width < 1200
                      ? 3
                      : 4,
              childAspectRatio: childAspectFactor,
              mainAxisSpacing: 62),
          itemCount: widget.movies.length ,
          // ignore: body_might_complete_normally_nullable
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.movies.length) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        onTapImage(widget.movies[index]);
                      },
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${widget.movies[index].posterPath}',
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.network(DefaultImage.defaultImage);
                        },
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movies[index].title!,
                         maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ConstColor.movieDetailsColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'rating: ${widget.movies[index].voteAverage}',
                        style: TextStyle(color: ConstColor.movieDetailsColor),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              if(apiHelper.isFetchingMoviesError!){
              return const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child:  Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            }
          }),
          if(isLoader)
          const Loader() 
      ]);
  }
}
}