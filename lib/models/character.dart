

import 'package:latom/models/anime.dart';

class Character {

  int id;  
  String name;
  int popularity; // Based on favortes field from Jikan API. Represents number of people that favorites the charater;
  late List<Anime> animeList = List<Anime>.empty();

  Character({required this.id, required this.name, required this.popularity});

  factory Character.fromJson(Map<String, dynamic> json){
    return Character(
        id: json['mal_id'],
        name: json['name'], 
        popularity: json['favorites'] 
    );
  }

  void addAnime(Anime anime){
    animeList.add(anime);
  }

  void addAnimes(List<Anime> animes){
    animeList.addAll(animes);
  }

}