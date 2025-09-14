
import 'dart:math';

import 'package:latom/core/network/client.dart';
import 'package:latom/core/network/response.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/models/character.dart';

class CharacterService {

  late final LTHtppClient client;

  CharacterService(){
    client = LTHtppClient();
  }

  Future<Iterable<Character>> fetchCharacters(String? name) async {
 
    String orderBy = 'favorites';
    String sort = 'desc';

    if (name == null || name.isEmpty){
      return Iterable<Character>.empty();
    }
    final Map<String, dynamic> queryParams = {
      'q':name
      ,'order_by':orderBy
      ,'sort':sort
    };

    LtHttpResponse res = await client.get(
       endpoint:'v4/characters'
      ,queryParams:queryParams
    );
    if (res.statusCode != 200){
      return Iterable<Character>.empty();
    }
    return Character.fromJsonList(res.content['data']);
  }

  Future<void> populateCharacterImages(Character character) async {
    LtHttpResponse res = await client.get(
      endpoint:'v4/characters/${character.id}/pictures'
    );
    if (res.statusCode != 200){
      return;
    }
    final data = res.content['data'];
    List<String> imgList = data
      .map((img) => img['webp']['image_url'] as String)
      .whereType<String>()
      .toList();
    character.addImages(imgList);
  }

  Future<void> populateCharacterAnimes(Character character) async {
    LtHttpResponse res = await client.get(
      endpoint:'v4/characters/${character.id}/anime'
    );
    if (res.statusCode != 200){
      return;
    }
    final animes = res.content['data'];
    List<Anime> animeList = animes
      .map((anime) => Anime.fromJson(anime['anime']))
      .toList();
    character.addAnimes(animeList);
  }

  Future<Character> getRandomCharacter(int topRateLimit) async {

    Random random = Random();

    Character? result;
    String orderBy = 'favorites';
    String sort = 'desc';
    int limit = 1;

    while (result == null){
      int animeTopPosition = random.nextInt(topRateLimit);

      final Map<String, dynamic> queryParams = {
        'limit': limit.toString()
        ,'page': animeTopPosition.toString()
        ,'order_by':orderBy
        ,'sort':sort
      };
      
      LtHttpResponse res = await client.get(
        endpoint:'v4/characters'
        ,queryParams:queryParams
      );
      if (res.statusCode == 200){
        result = Character.fromJson(res.content['data'][0]);
      }
    }
    return result;
  }

}