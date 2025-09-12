import 'dart:math';

import 'package:latom/core/network/client.dart';
import 'package:latom/core/network/response.dart';
import 'package:latom/models/anime.dart';

class AnimeService {

  late final LTHtppClient client;

  AnimeService(){
    client = LTHtppClient();
  }

  Future<Anime?> getAnimeById(int id) async {
    LtHttpResponse res = await client.get(endpoint:'v4/anime/$id');
    if (res.statusCode != 200){
      return null;
    }
    return Anime.fromJson(res.content["data"]);
  }

  Future<Iterable<Anime>> fetchAnimes(String? englishTitle) async {
    String page = '1';
    String limit = '5';
    String minScore = '6';

    if (englishTitle == null || englishTitle.isEmpty){
      return Iterable<Anime>.empty();
    }
    final Map<String, dynamic> queryParams = {
      'q':englishTitle
      ,'page':page
      ,'limit':limit
      ,'min_score':minScore
    };

    LtHttpResponse res = await client.get(
       endpoint:'v4/anime'
      ,queryParams:queryParams
    );
    if (res.statusCode != 200){
      return Iterable<Anime>.empty();
    } 
    return Anime.fromJsonList(res.content['data']);
  }

  Future<Iterable<Anime>> fetchTopAnimes({required int page, int limit = 10}) async {
    
    final Map<String, dynamic> queryParams = {
      'limit': limit.toString()
      ,'page': page.toString()
    };

    LtHttpResponse res = await client.get(
       endpoint:'v4/top/anime'
      ,queryParams:queryParams
    );

    if (res.statusCode != 200){
      return Iterable<Anime>.empty();
    } 
    return Anime.fromJsonList(res.content['data']);
  }

  Future<Anime> getRandomAnime(int topRateLimit) async {

    Anime? result;

    Random random = Random();

    while (result == null){
      int animeTopPosition = random.nextInt(200);
      final Map<String, dynamic> queryParams = {
        'limit': 1.toString()
        ,'page': animeTopPosition.toString()
      };

      LtHttpResponse res = await client.get(
        endpoint:'v4/top/anime'
        ,queryParams:queryParams
      );
      if (res.statusCode != 200){
        result = Anime.fromJson(res.content['data'][0]);
      }
    }
    return result!;
  }

  Future<String> getAnimeRandomWebpImage(Anime anime) async {
    
    LtHttpResponse res = await client.get(
      endpoint:'v4/anime/${anime.id}/pictures'
    );
    if (res.statusCode != 200){
      return '';
    }
    return res.content['data'][Random().nextInt(res.content['data'].length)]['webp']['image_url'];
  }

}