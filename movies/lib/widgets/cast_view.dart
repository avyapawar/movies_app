import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_color.dart';
import 'package:movies_app/model/cast_model.dart';

class CastDetail extends StatelessWidget {
  const CastDetail({super.key, required this.cast});
  final Cast cast;
  @override
  Widget build(BuildContext context) {

    return Container(
      height:MediaQuery.of(context).size.height - kToolbarHeight - 80 ,
      width: 120,
      child: Column(
        children: [
          Image.network('https://image.tmdb.org/t/p/w500${cast.profilePath}',
              height: 150,
              fit: BoxFit.cover,
              width: 120, errorBuilder: (context, error, stackTrace) {
            return Container(
                height: 150,
                width: 120,
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                ));
          }),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cast.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ConstColor.movieDetailsColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'character : ${cast.character}',
                 maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ConstColor.movieDetailsColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
