import 'package:flutter/material.dart';
import 'package:netflix_clone/model/upcoming_movie_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingMovies;
  @override
  void initState() {
    upcomingMovies = ApiServices().upcomingMovieData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/logo.png',height: 50,width: 120,),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: (){},
                child: Icon(Icons.search,color: Colors.white,size: 30,)),
          ),
          Container(
            height: 27,
            width: 27,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}
