import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/movie_details_model.dart';
import 'package:netflix_clone/model/movie_recommendation_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/utils/AppUrl.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;

  const MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailsModel> movieDetails;
  late Future<MovieRecommendationsModel> recommendations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetails = ApiServices().movieDetails(widget.id);
    recommendations = ApiServices().movieRecommendation(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: movieDetails,
        builder: (context, snapshot) {
          final genre = snapshot.data!.genres
              .map((genre) => genre.name)
              .join(',');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:
                              '${AppUrls.imageUrl}${snapshot.data!.backdropPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SafeArea(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        snapshot.data!.releaseDate.year.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      SizedBox(width: 10),
                      Text(
                        genre,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.overview,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                    future: recommendations,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return SizedBox();
                      } else if (snapshot.hasData) {
                        return snapshot.data!.results.isEmpty?SizedBox():Column(
                          children: [
                            Text(
                              'More Like This',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap:true,
                              physics:NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                                childAspectRatio: 1.5/2,
                              ),
                              itemCount:snapshot.data!.results.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(id: snapshot.data!.results[index].id)));
                                  },
                                  child: SizedBox(
                                    child: CachedNetworkImage(imageUrl: "${AppUrls.imageUrl}${
                                        snapshot.data!.results[index].backdropPath
                                    }",fit: BoxFit.cover,),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        throw Exception('failed to load data from api');
                      }
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(child: Text(snapshot.error.toString()));
          } else {
            throw Exception('Failed to load data from API');
          }
        },
      ),
    );
  }
}
