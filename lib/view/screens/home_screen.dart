import 'package:flutter/material.dart';
import 'package:netflix_clone/model/tv_series_model.dart';
import 'package:netflix_clone/model/upcoming_movie_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/utils/AppUrl.dart';
import 'package:netflix_clone/view/widgets/custom_carousel.dart';
import 'package:netflix_clone/view/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingMovies;
  late Future<UpcomingMovieModel> nowPlayingMovies;
  late Future<TvSeriesModel> tvSeriesCarousel;

  @override
  void initState() {
    upcomingMovies = ApiServices().upcomingMovieData();
    nowPlayingMovies = ApiServices().nowPlayingMovieData();
    tvSeriesCarousel = ApiServices().tvSeriesData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/logo.png', height: 50, width: 120),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.search, color: Colors.white, size: 30),
            ),
          ),
          Container(
            height: 27,
            width: 27,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(future: tvSeriesCarousel, builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }else if(snapshot.hasData){
                return CustomCarousel(data: snapshot.data!);
              }else{
                throw Exception('failed to load data from api');
              }

            }),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: upcomingMovies,
                headlineText: 'Upcoming',
              ),
            ),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: nowPlayingMovies,
                headlineText: 'Now Playing',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
