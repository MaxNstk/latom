

import 'package:latom/models/anime.dart';

class Character {

  int id;  
  String name;
  int popularity; // Based on favortes field from Jikan API. Represents number of people that favorites the charater;

  List<String> imagesUrls = []; 
  List<Anime> animeList = [];

  Character({required this.id, required this.name, required this.popularity});

  factory Character.fromJson(Map<String, dynamic> json){
    Character character =  Character(
        id: json['mal_id'],
        name: json['name'], 
        popularity: json['favorites'] 
    );
    character.imagesUrls.add(json['images']['webp']['image_url']);
    return character;
  }

  static Iterable<Character> fromJsonList(List<dynamic> jsonList)  {
    final List<Character> characterList = jsonList.map((item) => Character.fromJson(item)).toList();
    return characterList;                                      
  }

  void addAnime(Anime anime){
    animeList.add(anime);
  }

  void addAnimes(List<Anime> animes){
    animeList.addAll(animes);
  }

}