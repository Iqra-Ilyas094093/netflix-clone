import 'package:netflix_clone/utils/keys.dart';

class AppUrls{
 static const baseUrl = 'https://api.themoviedb.org/3';
 static String key = '?api_key=${KeyUtils.API_KEY}';

 static String upcomingMoviesEndpoint = '/movie/upcoming';
}