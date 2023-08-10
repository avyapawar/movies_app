import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/constant/const_color.dart';
import 'package:movies_app/helper/api_helper.dart';
import 'package:movies_app/model/cast_model.dart';
import 'package:movies_app/model/movie_detail_model.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/widgets/cast_view.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movie});
  final MovieModel movie;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiHelper apiHelper = ApiHelper();
  List<Cast> totalCasts = [];
  MovieDetailModel? movieDetail;
  bool isLoading = true;
  @override
  void initState() {
    _fetchMovieDetail();
    _fetchCastdetail();
    super.initState();
  }

  void _fetchMovieDetail() async {
    await apiHelper.fetchMovieDetail(widget.movie.id!).then((value) {
      setState(() {
        movieDetail = value;
        isLoading = false;
      });
    });
  }

  void _fetchCastdetail() async {
    final fetchedCastDetails = await apiHelper.fetchCastList(widget.movie.id!);
    setState(() {
      totalCasts = fetchedCastDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final containerHeight = ((height - kToolbarHeight) / 2);
    final containerWidth = width * 0.5;

    String getGeners(MovieDetailModel moviDetail) {
      String generes = '';
      for (int i = 0; i < moviDetail.genres!.length; i++) {
        generes = '$generes${movieDetail!.genres![i].name},';
      }
      return generes;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.movie.title!,
          style: const TextStyle(color: ConstColor.white),
        ),
        backgroundColor: ConstColor.appBarBackgroundcolor,
       
      ),
      backgroundColor: ConstColor.screenBackgroundColor,
      body: isLoading
          ? SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: HexColor('#020a16')),
                          width: width > 800 ? width * 0.5 : width - 40,
                          height: (height * 0.5) - kToolbarHeight - 20,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            movieDetail != null
                                                ? 'https://image.tmdb.org/t/p/w500${movieDetail!.posterPath}'
                                                : 'https://media.comicbook.com/files/img/default-movie.png',
                                            height: containerHeight *
                                                (150 / containerHeight),
                                            width: containerWidth *
                                                (100 / containerWidth),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  movieDetail?.title ?? "",
                                                  style: TextStyle(
                                                      color: ConstColor
                                                          .movieDetailsColor),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Rating : ${movieDetail?.voteAverage}',
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#6e91b8')),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              style: BorderStyle
                                                                  .solid),
                                                          color: HexColor(
                                                              '#010a16')),
                                                      child: Text(
                                                        '${movieDetail!.runtime} min ',
                                                        style: TextStyle(
                                                          color: HexColor(
                                                              '#a5a8ad'),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      movieDetail != null
                                                          ? getGeners(
                                                              movieDetail!)
                                                          : "",
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              '#b1c5dd')),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  DateFormat('EEE d MMM yyyy')
                                                      .format(movieDetail!
                                                          .releaseDate!),
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#b5b7bb')),
                                                )
                                              ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Overview',
                                        style: TextStyle(
                                          color: HexColor('#adb5c0'),
                                          fontSize: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        movieDetail!.overview!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: HexColor('#adb5c0')),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                        if (width >= 800)
                          SizedBox(
                            height: ((height - kToolbarHeight) / 2) - 50,
                            width: width / 2 - 40,
                            child: Image.network(
                              movieDetail != null
                                  ? 'https://image.tmdb.org/t/p/w500${movieDetail!.backdropPath}'
                                  : 'https://media.comicbook.com/files/img/default-movie.png',
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (width <= 800)
                      SizedBox(
                        height: (height - kToolbarHeight) / 2 - 40,
                        width: width,
                        child: Image.network(
                          movieDetail != null
                              ? 'https://image.tmdb.org/t/p/w500${movieDetail!.backdropPath}'
                              : 'https://media.comicbook.com/files/img/default-movie.png',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        'Cast',
                        style: TextStyle(color: HexColor('#fefdfd')),
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: (height / 2) - kToolbarHeight - 68,
                        width: width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: totalCasts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: CastDetail(cast: totalCasts[index]),
                              );
                            }))
                  ],
                ),
              ),
            ),
    );
  }
}
