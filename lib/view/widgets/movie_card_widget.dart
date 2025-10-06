import 'package:flutter/material.dart';
import 'package:netflix_clone/model/upcoming_movie_model.dart';

import '../../utils/AppUrl.dart';

class MovieCardWidget extends StatefulWidget {
  final Future<UpcomingMovieModel> future;
  final String headlineText;
  const MovieCardWidget({super.key, required this.future, required this.headlineText});

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: widget.future, builder: (context,snapshot){
      final data = snapshot.data!.results;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.headlineText,style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
                itemCount:data.length,
                scrollDirection:Axis.horizontal,
                itemBuilder: (context,index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network('${AppUrls.imageUrl}${data[index].posterPath}'),
                  );
                }),
          )
        ],
      );
    });
  }
}
