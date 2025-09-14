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

    Random random = Random();
    Anime? result;
    int limit = 1;

    while (result == null){
      int animeTopPosition = random.nextInt(200);
      final Map<String, dynamic> queryParams = {
        'limit': limit.toString()
        ,'page': animeTopPosition.toString()
      };

      LtHttpResponse res = await client.get(
        endpoint:'v4/top/anime'
        ,queryParams:queryParams
      );
      if (res.statusCode == 200){
        result = Anime.fromJson(res.content['data'][0]);
      }
    }
    return result;
  }

  Future<void> pupulateAnimeImages(Anime anime) async {
    LtHttpResponse res = await client.get(
      endpoint:'v4/anime/${anime.id}/pictures'
    );
    if (res.statusCode != 200){
      return;
    }
    final animeData = res.content['data'];
    List<String> imgList = animeData
      .map((img) => (img.containsKey('webp')? img['webp']: img['jpg'])['image_url'] as String)
      .whereType<String>()
      .toList();
    anime.addImages(imgList);
  }
  
  Future<List<Anime>> getRandomAnimes({required int animeCount, int dificulty = 1 }) async {
    
    List<Anime> animeList = [];

    for (int i = 0; i < animeCount; i++){
      Anime curAnime = await getRandomAnime(200);
      await pupulateAnimeImages(curAnime);
      animeList.add(curAnime);
    }
    return animeList;
  }

}