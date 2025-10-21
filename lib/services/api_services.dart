import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/movie_details_model.dart';
import 'package:netflix_clone/model/movie_recommendation_model.dart';
import 'package:netflix_clone/model/popular_movies_model.dart';
import 'package:netflix_clone/model/searchModel.dart';
import 'package:netflix_clone/model/tv_series_model.dart';
import 'package:netflix_clone/model/upcoming_movie_model.dart';
import 'package:netflix_clone/utils/keys.dart';

import '../utils/AppUrl.dart';
import 'dart:developer' as dev;

class ApiServices{


  Future<UpcomingMovieModel> upcomingMovieData()async{
    final String url = '${AppUrls.baseUrl}${AppUrls.upcomingMoviesEndpoint}${AppUrls.key}';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if(response.statusCode == 200){
      dev.log('success');
      print(response.statusCode);
      print(response.body);
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('${response.statusCode} ${e.toString()}');
    }
  }
  Future<UpcomingMovieModel> nowPlayingMovieData()async{
    final String url = '${AppUrls.baseUrl}${AppUrls.nowPlayingEndpoint}${AppUrls.key}';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if(response.statusCode == 200){
      dev.log('success');
      print(response.statusCode);
      // print(response.body);
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('${response.statusCode} ${e.toString()}');
    }
  }
  Future<TvSeriesModel> tvSeriesData()async{
    final String url = '${AppUrls.baseUrl}${AppUrls.tvSeriesEndpoint}${AppUrls.key}';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if(response.statusCode == 200){
      dev.log('success');
      print(response.statusCode);
      // print(response.body);
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('${response.statusCode} ${e.toString()}');
    }
  }
  Future<PopularMoviesModel> PopularMoviesData()async{
    final String url = '${AppUrls.baseUrl}${AppUrls.popularMoviesEndpoint}${AppUrls.key}';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl);
    if(response.statusCode == 200){
      dev.log('success for popularMovies');
      print(response.statusCode);
      print(response.body);
      return PopularMoviesModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('${response.statusCode} ${e.toString()}');
    }
  }


  Future<SearchModel> searchMovieData(String query)async{
    final String url = '${AppUrls.baseUrl}${AppUrls.searchQueryEndpoint}?query=$query';
    final parsedUrl = Uri.parse(url);
    final response = await http.get(parsedUrl,headers: {
      'Authorization': 'Bearer ${KeyUtils.AUTHORIZE_TOKEN}',
    });
    if(response.statusCode == 200){
      dev.log('success');
      print(response.statusCode);
      // print(response.body);
      return SearchModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('${response.statusCode} ${e.toString()}');
    }
  }
  Future<MovieDetailsModel> movieDetails(int id)async{
    final url = '${AppUrls.baseUrl}${AppUrls.MoviesDetailsEndpoint}$id${AppUrls.key}';
    final response = await http.get(Uri.parse(url));
    print(url);
    print(response.statusCode);
    if(response.statusCode == 200){
      dev.log('success');
      final data = jsonDecode(response.body);
      // print(data);
      print('Response body: ${response.body}');
      return MovieDetailsModel.fromJson(data);
    }else{
      print(response.statusCode);
      throw Exception(e.toString());
    }
  }

  Future<MovieRecommendationsModel> movieRecommendation(int id)async{
    final url = '${AppUrls.baseUrl}/movie/$id/recommendations${AppUrls.key}';
    print('url for recommendation api is $url');
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      print('Response body ${response.body}');
      return MovieRecommendationsModel.fromJson(data);
    }else{
      throw Exception('failed to load data from api for recommendations more like this');
    }
  }
}