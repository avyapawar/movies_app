import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_color.dart';
import 'package:movies_app/constant/const_default_image.dart';
import 'package:movies_app/helper/api_helper.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/model/search_notifier.dart';
import 'package:movies_app/screens/detail_screen.dart';
import 'package:movies_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class SearchedScreenPage extends StatefulWidget {
  const SearchedScreenPage({
    super.key,
  });
  @override
  State<SearchedScreenPage> createState() => _SearchedScreenPageState();
}

class _SearchedScreenPageState extends State<SearchedScreenPage> {
  int currentPage = 2;
  ApiHelper fetchMovieHepler = ApiHelper();
  ScrollController scrollController = ScrollController();
  SearchNotifier searchNotifier = SearchNotifier();

  @override
  void initState() {
    scrollController.addListener(
      () {
        _onScroll(searchNotifier.searchedData);
      },
    );
    fetchMovieHepler.isSearchingError = false;
    super.initState();
  }

  void _onScroll(String eneredData) {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0 &&
          searchNotifier.isSearching) {
        searchNotifier.onScrollFetchSearchedMovies(eneredData, currentPage);
        currentPage++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final childAspectFactor = size.width < 1200 ? 1.0 : 1.35;

    void _onTapImage(MovieModel movie) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DetailScreen(movie: movie);
      }));
    }

    return ChangeNotifierProvider.value(
        value: searchNotifier,
        child: Consumer<SearchNotifier>(
            builder: (context, searchNotifier, child) {
          if (fetchMovieHepler.isSearchingError!) {
            return Center(
              child: Container(
                  color: Colors.red,
                  child: const Text("oops no internate !...")),
            );
          }

          return searchNotifier.hasData ? Stack(
            children: [  Padding(
                padding: const EdgeInsets.all(20),
                child: searchNotifier.searchedData.isNotEmpty
                    ? GridView.builder(
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width < 750
                              ? 2
                              : size.width > 750 && size.width < 1200
                                  ? 3
                                  : 4,
                          childAspectRatio: childAspectFactor,
                          mainAxisSpacing: 62,
                        ),
                        itemCount: searchNotifier.searchedMovie.length +
                            (searchNotifier.isSearching ? 1 : 0),
                        itemBuilder: (BuildContext context, int index) {
                          if (index < searchNotifier.searchedMovie.length) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _onTapImage(
                                          searchNotifier.searchedMovie[index]);
                                    },
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${searchNotifier.searchedMovie[index].posterPath}',
                                      errorBuilder: (BuildContext context,
                                          Object error, StackTrace? stackTrace) {
                                        return Image.network(
                                          DefaultImage.defaultImage,
                                          height: 150,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      searchNotifier.searchedMovie[index].title!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ConstColor.movieDetailsColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'rating: ${searchNotifier.searchedMovie[index].voteAverage}',
                                      style: TextStyle(
                                          color: ConstColor.movieDetailsColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          // } else if (searchNotifier.isSearching) {
                          //   return const Loader();
                          } else {
                            return const SizedBox.shrink();
                          }
                        })
                    : const Center(
                        child: Text('no searched Item'),
                      )),
                      if(searchNotifier.isLoader)
const Loader()
                      
             ] ): const Center(
                        child: Text('no searched Item FOUND ......... '),
                      );
        }));
  }
}
