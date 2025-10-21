import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/popular_movies_model.dart';
import 'package:netflix_clone/model/searchModel.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/utils/AppUrl.dart';
import 'package:netflix_clone/view/screens/movie_details_Screen.dart';
import 'package:netflix_clone/view/widgets/movie_card_widget.dart';

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

            Expanded(
              child: searchController.text.isEmpty
                  ? FutureBuilder<PopularMoviesModel>(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      final data = snapshot.data?.results;
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else if(snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()),);
                      }else if(snapshot.hasData){
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data?.length,
                          itemBuilder: (context, index) {
                            var topSearch = data?[index];
                            if (index == 0) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 10),
                                child: Text(
                                  "Top Searches",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            } else {
                              // List items
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(id: topSearch.id)));
                                  },
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          '${AppUrls.imageUrl}${topSearch!.backdropPath}',
                                          fit: BoxFit.fitHeight,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          topSearch.title,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      }else{
                        throw Exception('Unable to fetch data from API');
                      }
                    }
                  )
                  : (search == null)
                  ? const SizedBox.shrink()
                  : GridView.builder(
                padding: const EdgeInsets.all(10),
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.2 / 2,
                ),
                itemCount: search!.results.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(id: search!.results[index].id)));
                    },
                    child: Column(
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
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
