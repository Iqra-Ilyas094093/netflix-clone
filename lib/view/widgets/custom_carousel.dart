import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/tv_series_model.dart';
import 'package:netflix_clone/utils/AppUrl.dart';

class CustomCarousel extends StatelessWidget {
  final TvSeriesModel data;
  const CustomCarousel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider.builder(itemCount: data.results.length, itemBuilder: (context,index,realIndex){
      return Container(
        height: size.height* 0.33>300?300:size.height*0.33,
        child: Image.network('${AppUrls.imageUrl}${data.results[index].backdropPath}'),
      );
    }, options: CarouselOptions(
      height: size.height* 0.33>300?300:size.height*0.33,
      autoPlayInterval: Duration(seconds: 2),
      autoPlay: true,
      scrollDirection: Axis.horizontal,
      enlargeCenterPage: true,
      aspectRatio: 16/9,
    ));
  }
}
