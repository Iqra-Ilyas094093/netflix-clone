import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/popular_movies_model.dart';
import 'package:netflix_clone/model/searchModel.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/utils/AppUrl.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<PopularMoviesModel> popularMovies;

  SearchModel? search;

  searchOperation(String query) {
    ApiServices().searchMovieData(query).then((results) {
      setState(() {
        search = results;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularMovies = ApiServices().PopularMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: TextFormField(
                controller: searchController,
                cursorColor: Colors.grey.shade500,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.withValues(alpha: 0.3),
                    size: 28,
                  ),
                  suffixIcon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey.withValues(alpha: 0.3),
                    size: 28,
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                  } else {
                    searchOperation(searchController.text);
                  }
                },
              ),
            ),

            searchController.text.isEmpty
                ? FutureBuilder(future: popularMovies, builder: (context,snapshot){
              final data = snapshot.data!.results;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top Searches',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  Expanded(
                    child: ListView.builder(
                        itemCount:data.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection:Axis.vertical,
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
            })
                : search == null
                ? SizedBox.shrink()
                : Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.2 / 2,
                    ),
                    itemCount: search?.results.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          search!.results[index].backdropPath == null
                              ? Image.asset('assets/netflix.png', height: 140)
                              : CachedNetworkImage(
                                  imageUrl:
                                      '${AppUrls.imageUrl}${search!.results[index].backdropPath}',
                                  height: 120,
                                ),
                          Text(
                            search!.results[index].originalTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
