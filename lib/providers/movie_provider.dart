import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _apikey= '980b4fa109f618cb83290ea97de147b9';
  String _baseUrl= 'api.themoviedb.org';
  String _language= 'es-Es';
  
  List<Movie> onDisplayMovies=[];
  List<Movie> popularMovies=[];
  Map<int,List<Cast>> moviesCast = {};
  
  int _popularPage = 0 ;

  MoviesProvider() {
    print('Moviesprovider inicializado');

    getOnDisplayMovies(); 
    getPopularMovies();
    
  }

  Future<String> _getJsonData (String endPoint, [int page = 1] ) async {
     final url = Uri.https( _baseUrl, endPoint, {
        'api_key'   :_apikey,
        'language' :_language,
        'page'      : '$page'
      });

  final response = await http.get(url);
  return response.body;
  }

  getOnDisplayMovies() async {
  
  final jsonData= await this._getJsonData('3/movie/now_playing');//final jsonData=  await getJsonData('3/movie/now_playing');
  final nowPlayingResponse= NowPlayingResponse.fromJson(jsonData);
  onDisplayMovies= nowPlayingResponse.results;
  notifyListeners();
  }

  getPopularMovies () async  {
    _popularPage++ ;

    final jsonData= await this._getJsonData('3/movie/popular',_popularPage );//final jsonData=  await getJsonData('3/movie/popular',_popularPage );   
    final popularResponse= PopularResponse.fromJson(jsonData);

    popularMovies= [...popularMovies,...popularResponse.results];
    //print(popularMovies);
    notifyListeners();
  }
  Future<List<Cast>> getMovieCast(int movieId) async{
    print('pidiendo');
    
    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsonData= await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId]= creditsResponse.cast;

    return creditsResponse.cast; 
  }

  Future<List<Movie>> searchMovie (String query) async {
     final url = Uri.https( _baseUrl, '3/search/movie', {
        'api_key'   :_apikey,
        'language' :_language,
        'query'      : query  
      });
      final response = await http.get(url);
      final searchResponse= SearchResponse.fromJson(response.body);
      return searchResponse.results;
  }
}