import 'dart:math';

import 'package:latom/core/network/client.dart';
import 'package:latom/core/network/response.dart';
import 'package:latom/models/anime.dart';

class CharacterService {

  late final LTHtppClient client;

  CharacterService(){
    client = LTHtppClient();
  }

  Future<Iterable<Anime>> fetchCharacters(String? name) async {
 
    String page = '1';
    String limit = '5';
    String minScore = '6';

    if (name == null || name.isEmpty){
      return Iterable<Anime>.empty();
    }
    final Map<String, dynamic> queryParams = {
      'q':name
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

    // guarantee the anime is valid
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
      if (res.statusCode == 200){
        result = Anime.fromJson(res.content['data'][0]);
      }
    }
    return result;
  }

  Future<String> getAnimeRandomWebpImage(Anime anime) async {
    
    LtHttpResponse res = await client.get(
      endpoint:'v4/anime/${anime.id}/pictures'
    );
    if (res.statusCode != 200){
      return '';
    }

    Random random = Random();

    while (res.content['data'].length > 0){
      int idx = random.nextInt(res.content['data'].length) - 1;
      String img = res.content['data'][idx]['webp']['image_url'];
      if (img != ''){
        return img;
      }
      res.content['data'].removeAt(idx);
    }
    return '';
  }

  Future<Map<Anime, String>> getRandomAnimesAndImages({required int animeCount, int dificulty = 1 }) async {
    
    Map<Anime, String> animesMap = {};

    for (int i = 0; i < animeCount; i++){
      Anime curAnime = await getRandomAnime(200);
      String curAnimeImg = await getAnimeRandomWebpImage(curAnime);
      animesMap.addAll({curAnime:curAnimeImg});
    }
    return animesMap;
  }

}