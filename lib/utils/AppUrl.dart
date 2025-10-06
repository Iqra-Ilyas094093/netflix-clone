import 'package:netflix_clone/utils/keys.dart';

class AppUrls{
 static const baseUrl = 'https://api.themoviedb.org/3';
 static String key = '?api_key=${KeyUtils.API_KEY}';
 static const imageUrl = 'https://image.tmdb.org/t/p/w500';

 static String upcomingMoviesEndpoint = '/movie/upcoming';
 static String  nowPlayingEndpoint = '/movie/now_playing';
 static String tvSeriesEndpoint = '/tv/top_rated';
}